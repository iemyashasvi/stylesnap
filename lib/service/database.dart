import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class DatabaseMethods{
  static getcollection(){
    User? user = FirebaseAuth.instance.currentUser;
    // return FirebaseFirestore.instance.collection("Clothes").doc(user.ge)


  }
  Future addcloth(Map<String,dynamic> clothinfomap ,String id)async{
  return await FirebaseFirestore.instance.collection("Cloth").doc(id).set(clothinfomap);


}
}