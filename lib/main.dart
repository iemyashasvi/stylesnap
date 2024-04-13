import 'package:flutter/material.dart';
import 'package:stylesnap/login.dart';
import 'package:stylesnap/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(),
        'signup':(context) =>SignUp(),


      }
  ));
}
