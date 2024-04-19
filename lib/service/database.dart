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
  dynamic getlist(){
    Query query=clothes.where('classification',isEqualTo: 'Lower wear');
    query.get().then((QuerySnapshot querySnapshot){
      final users = [];
      for (var doc in querySnapshot.docs) {
        users.add(doc.data());
      }

      print (users); // List of user data objects
    }).catchError((error) {
      print ("Error fetching users: $error");

    });

  }
  Future<String> getUpperwearData() async {
    final firestore = FirebaseFirestore.instance;
    final upperWearCollection = firestore.collection('clothes');
    final upperWearQuery = upperWearCollection.where('classification', isEqualTo: 'Lower wear');

    final snapshot = await upperWearQuery.get();

    if (snapshot.docs.isEmpty) {
      return 'No upperwear found.';
    }

    final buffer = StringBuffer();
    for (final doc in snapshot.docs) {
      final description = doc.data()['description'];
      final documentId = doc.id;
      buffer.writeAll(['Description: $description\n', 'Document ID: $documentId\n\n']);
    }

    return buffer.toString();
  }



}