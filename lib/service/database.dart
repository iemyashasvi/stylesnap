import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final user = FirebaseAuth.instance.currentUser;


class FirestoreService{
  final CollectionReference clothes=FirebaseFirestore.instance.collection('clothes');

  Stream<QuerySnapshot> getclothesstream(){
    final user = FirebaseAuth.instance.currentUser;

    final clothesstream = clothes.where('userId', isEqualTo: user!.uid).orderBy('timestamp', descending: true).snapshots();

    // final clothesstream =clothes.orderBy('timestamp',descending: true).snapshots();

    return clothesstream;

  }
  Future<void> deletecloth(String docid){
    return clothes.doc(docid).delete();
  }
  dynamic  getlist(){
    final user = FirebaseAuth.instance.currentUser;

    Query query=clothes.where('classification',isEqualTo: 'lower wear').where('userId', isEqualTo: user!.uid);
    query.get().then((QuerySnapshot querySnapshot){
      final users = [];
      for (var doc in querySnapshot.docs) {
        users.add(doc.data());
      }

      return (users); // List of user data objects
    }).catchError((error) {
      return ("Error fetching users: $error");

    });

  }
  Future<String> getUpperwearData(category) async {
    final user = FirebaseAuth.instance.currentUser;

    final firestore = FirebaseFirestore.instance;
    final upperWearCollection = firestore.collection('clothes');
    final upperWearQuery = upperWearCollection.where('classification', isEqualTo: category).where('userId', isEqualTo: user!.uid);
    print(user!.uid);

    final snapshot = await upperWearQuery.get();

    if (snapshot.docs.isEmpty) {
      return 'No upperwear found.';
    }

    final buffer = StringBuffer();
    for (final doc in snapshot.docs) {
      final type=doc.data()['type'];
      final color=doc.data()['color'];
      final description = doc.data()['description'];
      final documentId = doc.id;

      buffer.writeAll(['type:$type\n' ,'color: $color\n','Description: $description\n', 'Document ID: $documentId\n\n']);
    }

    return buffer.toString();
  }
  Future<String>getimgurl(String DocID)async{
    DocumentSnapshot snapshot =await clothes.doc(DocID).get();
    String url='';
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print(data); // Access the document data
      url=data['imageUrl'];
    }
    return url;

  }
  Future<List<String>> getData(category) async {
    final user = FirebaseAuth.instance.currentUser;

    final firestore = FirebaseFirestore.instance;
    final upperWearCollection = firestore.collection('clothes');
    final upperWearQuery = upperWearCollection.where('classification', isEqualTo: category).where('userId', isEqualTo: user!.uid);
    print(user!.uid);

    final snapshot = await upperWearQuery.get();

    List<String> links=[];
    final buffer = StringBuffer();
    for (final doc in snapshot.docs) {
      final url=doc.data()['imageUrl'];
      links.add(url);
    }
    return links;

  }



}