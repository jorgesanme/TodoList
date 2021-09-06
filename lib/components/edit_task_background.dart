
import 'package:flutter/material.dart';

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