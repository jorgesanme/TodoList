import 'package:flutter/material.dart';
import 'package:gsd_app/setting_drawer.dart';
import 'package:gsd_app/task_widget.dart';
import 'package:gsd_domain/gsd_domain.dart';

void main() {
  // añadir datos al repo
  addTestDataToRepo();
  runApp(GSDApp());
}

addTestDataToRepo() {
  for (int i = 0; i < 50; i++) {
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
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 20.0,
              color: Colors.white70,
              fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 18.0,
              color: Colors.redAccent),
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
          data: ThemeData(accentColor: Color(0xFF69f0ae)),
          child: FloatingActionButton(
            onPressed: () => TaskRepository.shared.toDo('Una nueva esperanza para todos los que quieren aprender el camino de la fuerza'),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
