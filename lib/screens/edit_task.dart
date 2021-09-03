import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsd_app/domain/task_widget.dart';
import 'package:gsd_domain/gsd_domain.dart';

class EditTask extends StatefulWidget {
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _controller = TextEditingController();
  late int index;

  late final widget;

  @override
  Widget build(BuildContext context) {
    index = _extractIndex(context)!;
    TaskWidget widget =
        TaskWidget(model: TaskRepository.shared[index], index: index);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit your Task',
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
                    //update the textfield for each letter tapped
                    // widget.model.description =  _controller.text;
                  });
                },
                decoration: InputDecoration(
                  hintText: widget.model.description,
                  labelText: 'Edit your task',
                  counterText: '${_controller.text.length.toInt()}',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.edit),
                  suffixIcon: _iconButton(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              ElevatedButton(
                onPressed: () async {
                  // showDialog(context: context, builder: createDialog);
                  returnText(context);
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Atención Pregunta!!'),
      content: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
            //update the textfield for each letter tapped
            // widget.model.description =  _controller.text;
          });
        },
        decoration: InputDecoration(
          hintText: 'enter text',
          labelText: 'Crear your task',
          counterText: '${_controller.text.length.toInt()}',
          border: OutlineInputBorder(),
          icon: Icon(Icons.edit),
          suffixIcon: _iconButton(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Pos-Fale'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Nooo!!!'))
      ],
    );
  }

  void returnText(BuildContext context) {
    String editedText;
    if (_controller.text.isEmpty) {
      editedText = 'Empty task';
    } else {
      editedText = _controller.text;
    }
    Navigator.pop(context, editedText);
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

  int? _extractIndex(BuildContext context) {
    final Object? index = ModalRoute.of(context)?.settings.arguments;
    return index as int?;
  }
}
