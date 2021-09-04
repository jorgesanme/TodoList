import 'package:flutter/material.dart';
import 'package:gsd_app/domain/User_Preferences.dart';

import 'constants.dart';

class MyToggleButtons extends StatefulWidget {
  const MyToggleButtons({Key? key}) : super(key: key);

  @override
  _MyToggleButtonsState createState() => _MyToggleButtonsState();
}

enum DoneOptions {
  Nothing,
  CrossOut,
  Delete,
}

class _MyToggleButtonsState extends State<MyToggleButtons> {
  List<bool> isSelected = [true, false, false];

  Map<int, String> doneSelectedOptions = {
    0: kOptionTextNothing,
    1: kOptionTextCrossOut,
    2: kOptionTextDelete,
  };


  String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            isSelected: isSelected,
            fillColor: Colors.grey,
            selectedColor: Color(0xFF699999),
            renderBorder: false,
            splashColor: Color(0xFF699999),
            highlightColor: Colors.orange,
            direction: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel_outlined),
                    ),
                    Text(
                      kOptionTextNothing,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.strikethrough_s_sharp),
                    ),
                    Text(
                      kOptionTextCrossOut,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_forever_outlined),
                    ),
                    Text(
                      kOptionTextDelete,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
            onPressed: (int newIndex) async {
              setState(() {
                for (int index = 0; index < isSelected.length; index++) {
                  if (index == newIndex) {
                    isSelected[index] = true;
                    selected = doneSelectedOptions[index];
                  } else {
                    isSelected[index] = false;
                  }
                }
              });
              if (selected == kOptionTextDelete) {
                selected =
                    await showDialog(context: context, builder: createDialog);
              }
              //Save selected into SharedPreferences
              UserPreferences.setUserDonePreference(selected!);

            },
          ),
        ],
      ),
    );
  }

  Widget createDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Atención Pregunta!!'),
      content: Text('Do yo want to delete all from repository??'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context, kOptionTextDeleteAll);
              },
            ),
            TextButton(
              child: Text('Nooo!!!'),
              onPressed: () {
                Navigator.pop(context, kOptionTextDelete);
              },
            )
          ],
        ),
      ],
    );
  }

  //todo -se debe extraer la opcion seleccionada de las setting para exponer
  List<bool> configureBotton() {
    String userSelected = UserPreferences.getUserPreference();
    print(userSelected);
    switch (userSelected) {
      case kOptionTextNothing:
        {
          setState(() {
            isSelected = [true, false, false];
          });
        }
        break;
      case kOptionTextCrossOut:
        {
          setState(() {
            isSelected = [false, true, false];
          });
        }
        break;
      case kOptionTextDelete:
        {
          setState(() {
            isSelected = [false, false, true];
          });

        }
        break;
      default:
        {
          setState(() {
            isSelected = [true, false, false];
          });

          break;
        }
    }

    return isSelected;
  }
}

/*
Text('Nothing', style: TextStyle(fontSize: 18),),
 */
