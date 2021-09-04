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
            returnText(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'Dado que me ha sido imposible navegar desde el FAB, se puede crear un Task desde aquí',
                  textAlign: TextAlign.justify),
              ElevatedButton(
                child: Text('Create New Task'),
                onPressed: () {
                  // showDialog(context: context, builder: createDialog);
                  _createNewTask(context);
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          returnText(context);
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 30.0,),
                      ElevatedButton(
                        onPressed: () async {
                          returnText(context);
                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void returnText(BuildContext context) {
    String editedText;
    if (_controller.text.isEmpty) {
      Navigator.pop(context);
    } else {
      editedText = _controller.text;
      Navigator.pop(context, editedText);
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

  Future<String?> _createNewTask(BuildContext context) async {
    final String? newTaskText = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => CreateTask(),
      ),
    );
    TaskRepository.shared.toDo(newTaskText.toString());
  }
}
