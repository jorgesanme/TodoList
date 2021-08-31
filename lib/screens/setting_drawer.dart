import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsd_app/components/my_togglebuttons.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsHeader(),
          DoneHeader(),
          DoneOptions(),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        children: const [
          Icon(
            Icons.settings,
            size: 64,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            'Settings',
            style: TextStyle(fontSize: 42, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class DoneHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(
            Icons.done,
            size: 30,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'What to do with "done" tasks?',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DoneOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyToggleButtons();
  }
}

/*
Column(
        children: [Text('Nothing'), Text('Grey out'), Text('Delete')]
            .map((e) => ElevatedButton(onPressed: null,
              child:  e ))
            .toList());
 */

/*
ListView(
  padding: EdgeInsets.zero,
  children: const <Widget>[
    DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 28.0),
        child: Text(
          'Menu Lateral:',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.add_a_photo_outlined),
      title: Text(
        'Añadir task',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.delete),
      title: Text(
        'Borrar task',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.tag_faces),
      title: Text(
        'Sonreir alegremente',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
    Divider(height: 10,thickness: 3, color: Colors.lightBlue,),
    ListTile(
      leading: Icon(Icons.add_a_photo_outlined),
      title: Text(
        'Añadir fotos',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.delete),
      title: Text(
        'Borrar todo',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.tag_faces),
      title: Text(
        'Sonreir alegremente',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 25.0,
          color: Colors.blue,
        ),
      ),
    ),
  ],
),
*/
