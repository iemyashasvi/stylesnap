import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';



class ClothingDetailsPage extends StatelessWidget {
  final DocumentSnapshot clothing;

  const ClothingDetailsPage({required this.clothing});

  @override
  Widget build(BuildContext context) {

    final FirestoreService firestoreService=FirestoreService();

    var id =clothing.id;

    Map<String, dynamic> data = clothing.data()! as Map<String, dynamic>;
    String type = data['type'];
    String description = data['description'];
    String classification = data['classification'];
    String color = data['color'];
    String url = data['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text(type), // Display clothing type in the details page app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(url),
            const SizedBox(height: 20.0),
            Text(
              "Color: $color",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Type: $type",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Description: $description",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Classification: $classification",
              style: const TextStyle(fontSize: 16.0),
            ),
            TextButton(onPressed: ()async{
              await firestoreService.deletecloth(id);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
              Navigator.pushNamed(context, 'wardrobe');
            }
            , child: Text('Delete Item')),
            TextButton(onPressed: ()async{
              firestoreService.getUpperwearData().then((data) {
                print(data); // This will print the combined text string
              });

            }
            , child: Text('Match'))
          ],
        ),
      ),
    );
  }
}
