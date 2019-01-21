import 'package:flutter/material.dart';

class CustomSnackBar{
  CustomSnackBar(this.message);
  final String message;


  SnackBar getSnack(){
    return SnackBar(content: Text("$message"),duration: Duration(seconds: 3),);
  }

  
}