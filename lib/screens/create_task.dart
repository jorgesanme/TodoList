

import 'package:flutter/material.dart';

enum buttonText {
  Cancel, Confirm
}

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
            returnText(context, buttonText.Cancel);
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
                  labelText: 'Create NEW task',
                  counterText: '${_controller.text.length.toInt()}',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.add_task),
                  suffixIcon: _iconButtonmy(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      returnText(context, buttonText.Cancel);
                    },
                    child: Text('Cancel'),),
                  SizedBox(width: 30.0,),
                  ElevatedButton(
                    onPressed: () async {
                      returnText(context, buttonText.Confirm);
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  IconButton? _iconButtonmy() {
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

  void returnText(BuildContext context, buttonText btnText) {
    String editedText;
    if (_controller.text.isEmpty|| btnText == buttonText.Cancel) {
      Navigator.pop(context);
    } else {
      editedText = _controller.text;
      Navigator.pop(context, editedText);
    }
    
  }

}
