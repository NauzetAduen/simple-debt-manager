import 'package:flutter/material.dart';

class CustomSnackBar{
  CustomSnackBar(this.message);
  final String message;


  SnackBar getSnack(){
    return SnackBar(content: Text("$message",textAlign: TextAlign.center),duration: Duration(milliseconds: 777),);
  }
}