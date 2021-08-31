import 'package:flutter/material.dart';

class MyToggleButtons extends StatefulWidget {
  const MyToggleButtons({Key? key}) : super(key: key);

  @override
  _MyToggleButtonsState createState() => _MyToggleButtonsState();
}

class _MyToggleButtonsState extends State<MyToggleButtons> {
  List<bool> isSelected = [true, false, false];

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
                    Text('Nothing', style: TextStyle(fontSize: 18),),
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
                    Text('Cross out', style: TextStyle(fontSize: 18),),
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
                    Text('Delete all', style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
            ],
            onPressed: (int newIndex){
              setState(() {
                for (int index = 0; index < isSelected.length; index++){
                  if(index == newIndex){
                    isSelected[index] = true;
                  }else{
                    isSelected[index] = false;
                  }
                }


              });
            },
          ),
        ],
      ),
    );
  }
}

/*
Text('Nothing', style: TextStyle(fontSize: 18),),
 */