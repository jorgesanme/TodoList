


import 'package:flutter/material.dart';

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