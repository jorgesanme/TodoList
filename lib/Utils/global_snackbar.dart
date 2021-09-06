

import 'package:flutter/material.dart';

class GlobalSnackBar{
  final String message;

  GlobalSnackBar({required this.message});
  static show(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2),
      duration: Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static showConfirm(BuildContext context, String message, Function onPress){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Confirm',
          onPressed: (){
             onPress;
          },

        ),
        content: Text(
          message,
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
  }

}