import 'package:flutter/material.dart';
import 'package:gsd_app/domain/User_Preferences.dart';
import 'package:gsd_app/screens/create_task.dart';
import 'package:gsd_app/domain/setting_drawer.dart';
import 'package:gsd_app/domain/task_widget.dart';
import 'package:gsd_domain/gsd_domain.dart';

import 'Utils/my_alertdialog.dart';

void main() async {
  // init the preferences
  WidgetsFlutterBinding.ensureInitialized();
  // añadir datos al repo
  addTestDataToRepo();
  UserPreferences.init();
  await UserPreferences.init();
  runApp(GSDApp());
}

addTestDataToRepo() {
  for (int i = 0; i < 5; i++) {
    if (i.isEven) {
      TaskRepository.shared.toDo('Tareas que debo hacer .$i');
    } else {
      TaskRepository.shared.done('Cosas que ya estan hechas .$i');
    }
  }
}

class GSDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF1D1E33),
        accentColor: Color(0xFF699999),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 20.0,
              color: Colors.white,
              fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
              fontFamily: "Pacifico", fontSize: 18.0, color: Colors.redAccent),
          headline6: TextStyle(
              fontFamily: "Pacifico", fontSize: 20.0, color: Colors.white),
          headline2: TextStyle(
              fontFamily: "Pacifico", fontSize: 14.0, color: Colors.white),
        ),
      ),
      title: 'GSD',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo List',
            style: TextStyle(
                fontFamily: "Pacifico", fontSize: 25.0, color: Colors.white),
          ),
        ),
        drawer: Drawer(
          child: SettingsDrawer(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TaskListWidget(
            model: TaskRepository.shared,
          ),
        ),
        floatingActionButton: Theme(
          data: ThemeData(
            accentColor: Color(0xFF699999),
          ),
          child: FloatingActionButton(
            // todo create a new widget where user can create a task
            onPressed: () {
              showDialog(context: context, builder: createDialog);
              // _createNewTask(context);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _createNewTask(BuildContext context) async {
    final String? newTaskText = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => CreateTask(),
      ),
    );
    TaskRepository.shared.toDo(newTaskText.toString());
  }

  Widget createDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Atención Pregunta!!'),
      content: Text('Do yo want to delete all from repository??'),
      actions: [
        TextButton(onPressed:(){}, child:Text('Pos-Fale'),),
        TextButton(onPressed: (){}, child: Text('Nooo!!!'))
      ],
    );
  }
}
