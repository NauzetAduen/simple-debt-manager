import 'package:flutter/material.dart';

class Styles{

   static final borderRounded = OutlineInputBorder(
     borderRadius: BorderRadius.circular(5.0)
   );

   static final paddingForm = const EdgeInsets.all(16.0);
   static final paddingFields = const EdgeInsets.symmetric(vertical: 10.0);

   static final paddingProggressIndicator = const EdgeInsets.all(12.0);
   static final progressIndicatorHeight = 30.0;
   static final progressIndicatorStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

   static final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  static final divider = Divider(color: Colors.redAccent);

  static final pieWidth = 300.0;
  static final pideHeight = 150.0;
  static final percentStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static final pieTitleStyle = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
  static final pieTitlePadding = const EdgeInsets.only(top: 20.0);


   static final defaultThemeData = ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.yellowAccent,
        brightness: Brightness.dark
        //primaryColorBrightness: Brightness.dark,
      );
}