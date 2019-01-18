import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(this.title);

  @override
  final Widget title;

  @override
  final bool centerTitle = true;
}
