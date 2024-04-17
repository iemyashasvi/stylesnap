import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylesnap/service/database.dart';

class Wardrobe extends StatefulWidget {
  const Wardrobe({super.key});

  @override
  State<Wardrobe> createState() => _WardrobeState();
}

class _WardrobeState extends State<Wardrobe> {
  final FirestoreService firestoreService=FirestoreService();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text( "Clothes")),

      body: Padding(

        padding: const EdgeInsets.only(left: 0.0,right: 0.0),
        child: StreamBuilder<QuerySnapshot>(

          stream: firestoreService.getclothesstream(),

          builder: (context,snapshot){
            if (snapshot.hasData){
              List clotheslist=snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 0
                ),


                itemCount: clotheslist.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot document = clotheslist[index];
                    String DocId=document.id;
                    Map <String ,dynamic> data=
                    document.data() as Map<String, dynamic>;
                    String type=data['type'];
                    String description=data['description'];
                    String classification=data['classification'];
                    String color=data['color'];
                    String url=data['imageUrl'];

                    // return ListTile(
                    //   leading: Image.network(url),
                    //   title: Text(type),
                    //   subtitle: Text(description),
                    // );
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width)/2.9,
                      height: 200,

                      child: Container(
                        margin: EdgeInsets.only(left: 20.0,right: 20.0),
                        child:Column(


                            children: [
                              Image.network(url,width: 125,height: 144),
                              Text(color),
                              Text(type),
                            ],

                          ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black),


                        ),


                      ),
                    );



                  }
              );
            }
            else{
               return const Text("NO CLothes added");
            }
          },
        ),
      )
    );
  }
}
