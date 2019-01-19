import 'package:flutter/material.dart';

class Styles{

   static final borderRounded = OutlineInputBorder(
     borderRadius: BorderRadius.circular(5.0)
   );

   static final paddingForm = const EdgeInsets.all(16.0);

   static final paddingFields = const EdgeInsets.symmetric(vertical: 10.0);


   static final defaultThemeData = ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.yellowAccent,
        brightness: Brightness.light
        //primaryColorBrightness: Brightness.dark,
      );
}