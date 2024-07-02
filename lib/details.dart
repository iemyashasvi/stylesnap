import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'service/requests.dart';

class ClothingDetailsPage extends StatefulWidget {
  final DocumentSnapshot clothing;

  const ClothingDetailsPage({required this.clothing});

  @override
  State<ClothingDetailsPage> createState() => _ClothingDetailsPageState();
}

class _ClothingDetailsPageState extends State<ClothingDetailsPage> {
  late List<String> secondIds;
  final FirestoreService firestoreService = FirestoreService();
  final SendRequest sendRequest = SendRequest();
  late List<String> links;
  late List<String> urls=[];

  @override
  void initState() {

    super.initState();

    Map<String, dynamic> data = widget.clothing.data()! as Map<String, dynamic>;
    String classification = data['classification'];
    _getlinks(classification);
    // _fetchData();
    print("hy");
  }
  Future<void> _getlinks(classification)async{
    if (classification=='upper wear'){
      var id = widget.clothing.id;
      urls= await firestoreService.getData('lower wear');

    }
    else{
      var id = widget.clothing.id;
      urls= await firestoreService.getData('upper wear');
    }
  }

  Future<void> _fetchData() async {
    secondIds = [];
    links = [];

    var id = widget.clothing.id;
    Map<String, dynamic> data = widget.clothing.data()! as Map<String, dynamic>;
    String type = data['type'];
    String description = data['description'];
    String classification = data['classification'];
    String color = data['color'];
    String url = data['imageUrl'];

    secondIds = await sendRequest.getid(id, classification, type, color, description);
    print("Second:");
    Future.delayed(Duration(seconds: 7), ()async {
      for (int i = 0; i < secondIds.length; i++) {
        String path = secondIds[i];
        links.add(await firestoreService.getimgurl(path));
          }

      print(secondIds);
      // Your code to be executed after 7 seconds
    });



    setState(() {}); // Trigger a rebuild after fetching data
  }

  @override
  Widget build(BuildContext context) {
    var id = widget.clothing.id;
    Map<String, dynamic> data = widget.clothing.data()! as Map<String, dynamic>;
    String type = data['type'];
    String description = data['description'];
    String classification = data['classification'];
    String color = data['color'];
    String url = data['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text(type), // Display clothing type in the details page app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Container(child: SizedBox(
                width: MediaQuery.of(context).size.width*.8,
                  height: MediaQuery.of(context).size.height*.4,
                  child: Image.network(url)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black),

                ),
              ),
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
              TextButton(
                onPressed: () async {
                  await firestoreService.deletecloth(id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
                  Navigator.pushNamed(context, 'wardrobe');
                },
                child: Text('Delete Item'),
              ),
              Divider(),
              SizedBox(height: 40.0,),
              FutureBuilder<void>(
                future: Future.delayed(Duration(seconds: 10), () {
                  print(secondIds.length);
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return GridView.builder(


                      itemCount: urls.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 165,
                            width: 183,
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                    child: Image.network(urls[index], width: 125, height: 144),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black),

                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
