import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class FirestoreService{
  final CollectionReference clothes=FirebaseFirestore.instance.collection('clothes');

  Stream<QuerySnapshot> getclothesstream(){
    final clothesstream =clothes.orderBy('timestamp',descending: true).snapshots();

    return clothesstream;

  }
  Future<void> deletecloth(String docid){
    return clothes.doc(docid).delete();
  }
}