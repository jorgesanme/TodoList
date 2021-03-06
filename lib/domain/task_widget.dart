import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsd_app/Utils/global_snackbar.dart';
import 'package:gsd_app/components/constants.dart';
import 'package:gsd_app/screens/edit_task.dart';
import 'package:gsd_domain/gsd_domain.dart';
import 'package:mow/mow.dart';
import '../components/delete_task_background.dart';
import '../components/edit_task_background.dart';
import '../components/image_widget.dart';
import 'User_Preferences.dart';

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
  String _pref = UserPreferences.getUserPreference();

  void _onCheckboxTap(bool? value) {
    final bool newValue = value ?? false;
    setState(() {
      _pref = UserPreferences.getUserPreference();
    });

    switch (_pref) {
      case kOptionTextDelete:
        {
          if (widget.model.state == TaskState.toDo) {
            setState(() {
              TaskRepository.shared.removeAt(widget.index);
              _confirmDelete(widget.model.description);
            });
          } else {
            widget.model.state = newValue ? TaskState.done : TaskState.toDo;
          }
          break;
        }
      case kOptionTextDeleteAll:
        {
          if (widget.model.state == TaskState.toDo) {
            setState(() {
               TaskRepository.shared.removeAllDone();
            });
          } else {
            widget.model.state = newValue ? TaskState.done : TaskState.toDo;
          }
          break;
        }
      case kOptionTextCrossOut:
        {
          widget.model.state = newValue ? TaskState.done : TaskState.toDo;
          break;
        }
      case kOptionTextNothing:
        {
          widget.model.state = newValue ? TaskState.done : TaskState.toDo;
          break;
        }
    }
  }

  /// borrar un task al desplazar una card
  void _onDismissedTask(DismissDirection direction) {
    final int oldLength = TaskRepository.shared.length;
    assert(TaskRepository.shared.length == oldLength - 1);
  }

  void _confirmDelete(String showText) {
    ScaffoldMessenger.of(_currentContext).showSnackBar(SnackBar(
      content: Text(
        '$showText \nDELETED',
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
        /// Edit a task
        final String? newValue = await Navigator.of(context).push<String>(
          MaterialPageRoute(
            builder: (context) => EditTask(),
            settings: RouteSettings(arguments: widget.index),
          ),
        );
        if (newValue != null) {
          setState(() {
            TaskRepository.shared
                .editTask(widget.index, widget.model, newValue);
          });
        }
        break;
      case DismissDirection.startToEnd:
        /// Delete de task
        //todo refactor this into a  SnackBar Widget o Utils
 /*
      String message = 'Are you sure to delete that note?';
      Function onPress = (){
         TaskRepository.shared.removeAt(widget.index);
        _confirmDelete(widget.model.description);
      };
      GlobalSnackBar.showConfirm(context, message, onPress);

 */

        ScaffoldMessenger.of(_currentContext).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: 'Confirm',
              onPressed: () {
                TaskRepository.shared.removeAt(widget.index);
                _confirmDelete(widget.model.description);
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

  checkPreference() {
    if (_pref == kOptionTextCrossOut && widget.model.state == TaskState.done) {
      return kTextTaskDoneStyle;
    } else if (_pref == kOptionTextNothing &&
        widget.model.state == TaskState.done) {
      return Theme.of(context).textTheme.bodyText1;
    } else {
      return kTextTaskTodoStyle;
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
            activeColor: Theme.of(context).accentColor,
            value: widget.model.state == TaskState.done,
            onChanged: _onCheckboxTap,
          ),
          title: Text(
            // cambiar el color del texto y tachado al se un task.done
            widget.model.description,
            style: checkPreference(),
          ),
          trailing: ImageWidget(
            imageName: 'taskImage',
          ),
        ),
      ),
    );
  }
}
