import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsd_app/domain/task_widget.dart';
import 'package:gsd_domain/gsd_domain.dart';

import 'create_task.dart';

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
            returnText(context, 'Cancel');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    //Falso cancel, el control de la cancelación lo hace el returnText()
                    onPressed: () async {
                      returnText(context, 'Cancel');
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      returnText(context, 'Confirm');
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

  void returnText(BuildContext context, String buttonText) {
    String editedText;
    if (_controller.text.isEmpty || buttonText == 'Cancel') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The edition has been canceled or the field was empty',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2),
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      editedText = _controller.text;
      Navigator.pop(context, editedText);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The edition has been done',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2),
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ));
    }
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
