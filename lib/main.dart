import 'package:flutter/material.dart';
import 'package:simple_debt_manager/styles/styles.dart';
import 'screens/main_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Debt Manager",
      theme: Styles.defaultThemeData,
      home: MainScreen(),
    );
  }
}