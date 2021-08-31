

import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new Task',
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: BackButton(
          onPressed: () {
            returnText(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
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
              ElevatedButton(
                onPressed: () {
                  returnText(context);
                },
                child: Text('Confirm'),),
            ],
          ),
        ),
      ),
    );
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

  void returnText(BuildContext context) {
    String editedText;
    if (_controller.text.isEmpty) {
      editedText = 'Empty task, you can edit ->';
    } else {
      editedText = _controller.text;
    }
    Navigator.pop(context, editedText);
  }

}
