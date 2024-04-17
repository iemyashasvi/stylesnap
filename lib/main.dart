// import 'dart:js';

// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stylesnap/home.dart';
import 'package:stylesnap/login.dart';
import 'package:stylesnap/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylesnap/wardrobe.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings=const Settings(
    persistenceEnabled: true,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(),
        'signup':(context) =>SignUp(),
        'homescreen':(context) =>HomeScreen(),
        'wardrobe':(context)=>Wardrobe()



      }
  ));
}
