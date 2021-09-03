

import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({Key? key}) : super(key: key);

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  final _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Atención Pregunta'),
      content: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
          });
        },
        decoration: InputDecoration(
          hintText: 'Type what you want to do',
          labelText: 'Create your task',
          counterText: '${_controller.text.length.toInt()}',
          border: OutlineInputBorder(),
          icon: Icon(Icons.edit),
          suffixIcon: _iconButton(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      actions: <Widget>[
        TextButton(child: Text('Acept'), onPressed: (){
          Navigator.of(context).pop();
        }, ),
        TextButton(child: Text('Cancel'), onPressed: (){
          Navigator.of(context).pop();
        }, ),
      ],

    );
  }
  Widget showMyDialog(){
    return MyAlertDialog();
  }

  IconButton? _iconButton() {
    IconButton? iconClear;
    if (_controller.text.isEmpty) {
      iconClear = null;
    } else {
      iconClear = IconButton(
          onPressed: () {
            setState(() {
              _controller.clear();
            });
          },
          icon: Icon(Icons.clear));
    }
    return iconClear;
  }
}



