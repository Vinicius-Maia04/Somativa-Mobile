import 'package:app_somativa/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 31, 31, 31),
      primaryColor: Colors.red,
      primarySwatch: Colors.red,),
      debugShowCheckedModeBanner: false,

      home: Login(),
  ));
}
