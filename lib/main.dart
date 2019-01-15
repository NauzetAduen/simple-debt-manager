import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple Debt Manager",
      home: MainScreen(),
    );
  }
}