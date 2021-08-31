import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsd_app/edit_task.dart';
import 'package:gsd_domain/gsd_domain.dart';
import 'package:mow/mow.dart';

class TaskListWidget extends ModelWidget<TaskRepository> {
  TaskListWidget({required TaskRepository model, Key? key})
      : super(model: model, key: key);

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState
    extends ObserverState<TaskRepository, TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: TaskRepository.shared.length,
      itemBuilder: (context, index) {
        return TaskWidget(
          model: TaskRepository.shared[index],
          index: index,
        );
      },
    );
  }
}

class TaskWidget extends ModelWidget<Task> {
  late final int index;

  @override
  TaskWidget({required Task model, required int index, Key? key})
      : index = index,
        super(model: model, key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends ObserverState<Task, TaskWidget> {
  late BuildContext _currentContext;

  void _onCheckboxTap(bool? value) {
    final bool newValue = value ?? false;
    widget.model.state = newValue ? TaskState.done : TaskState.toDo;
  }

  /// borrar un task al desplazar una card
  void _onDismissedTask(DismissDirection direction) {
    final int oldLength = TaskRepository.shared.length;
    assert(TaskRepository.shared.length == oldLength - 1);
  }

  void _confirmDelete() {
    ScaffoldMessenger.of(_currentContext).showSnackBar(SnackBar(
      content: Text(
        'DELETED',
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.all(8),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white70,
    ));
  }

  Future<bool?> _confirmDismiss(DismissDirection direction) async {
    switch (direction) {
      case DismissDirection.endToStart:
        print('vamos a editar: muestra un SnackBar con el index del Task');
        final String? newValue = await Navigator.of(context).push<String>(
          MaterialPageRoute(
            builder: (context) => EditTask(),
            settings: RouteSettings(arguments: widget.index),
          ),
        );
        print('\n \n Esto devuelve el editado: $newValue \n \n');
        TaskRepository.shared.editTask(widget.index, widget.model, newValue!);
        setState(() {

        });
        break;
      case DismissDirection.startToEnd:

        /// Delete de task
        //todo refactor this into a Widget o Utils
        ScaffoldMessenger.of(_currentContext).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: 'Confirm',
              onPressed: () {
                TaskRepository.shared.removeAt(widget.index);
                _confirmDelete();
              },
            ),
            content: Text(
              'Are you sure to delete that note?',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            duration: Duration(seconds: 6),
            padding: EdgeInsets.symmetric(horizontal: 8),
            behavior: SnackBarBehavior.floating,
            width: 360.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: _onDismissedTask,
      confirmDismiss: _confirmDismiss,
      background: DeleteTaskBackground(alignment: MainAxisAlignment.start),
      secondaryBackground: EditTaskBackground(alignment: MainAxisAlignment.end),
      child: Card(
        elevation: 50.0,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Checkbox(
            value: widget.model.state == TaskState.done,
            onChanged: _onCheckboxTap,
          ),
          title: Text(
            widget.model.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}

_editTask(BuildContext context, int index) async {
  await Navigator.of(context).push<String>(
    MaterialPageRoute<String>(
      settings: RouteSettings(arguments: index),
      builder: (context) => EditTask(),
    ),
  );
}

class DeleteTaskBackground extends StatelessWidget {
  late final MainAxisAlignment aligment;

  DeleteTaskBackground({required MainAxisAlignment alignment})
      : aligment = alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: aligment,
          children: [
            Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Deleting Task',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskBackground extends StatelessWidget {
  late final MainAxisAlignment aligment;

  EditTaskBackground({required MainAxisAlignment alignment})
      : aligment = alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: aligment,
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Edit task',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
/* la imagen puesta a la derecha del texto
trailing: CircleAvatar(
            // child: Image.asset('images/flutter-icon.png'),
            child: Image.network('https://bit.ly/3zJBXeI'),
          ),
 */
