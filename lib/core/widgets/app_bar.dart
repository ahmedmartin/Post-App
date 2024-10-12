import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }