
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageName;

  ImageWidget({Key? key, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Image(
          image: AssetImage('images/$imageName.png'), fit: BoxFit.contain),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}