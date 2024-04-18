

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stylesnap/details.dart';
import 'package:stylesnap/home.dart';
import 'package:stylesnap/login.dart';
import 'package:stylesnap/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylesnap/wardrobe.dart';
import 'package:stylesnap/welcome.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  String route;
  if (firebaseUser!=null){
    route='homescreen';
  }
  else{
    route='welcome';

  }
  FirebaseFirestore.instance.settings=const Settings(
    persistenceEnabled: true,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      routes: {

        'login': (context) => MyLogin(),
        'signup':(context) =>SignUp(),
        'homescreen':(context) =>HomeScreen(),
        'wardrobe':(context)=>Wardrobe(),
        'welcome':(context)=>Welcome()
      }
  ));
}
