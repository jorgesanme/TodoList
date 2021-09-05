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
