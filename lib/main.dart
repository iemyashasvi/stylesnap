import 'package:flutter/material.dart';
import 'package:stylesnap/login.dart';
import 'package:stylesnap/signup.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(),
        'signup':(context) =>SignUp(),


      }
  ));
}
