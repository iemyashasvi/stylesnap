// import 'dart:html';
import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylesnap/widget/support_widget.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  File? image;
  String mytext='';
  bool scanning=false;
  // api=AIzaSyC-PmpJzovGFKUOMG-gdA3eo6cZjt_0oCM
  final apiUrl='https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=AIzaSyC-PmpJzovGFKUOMG-gdA3eo6cZjt_0oCM';

  final header={
    'Content-Type': 'application/json',
  };
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;


  String promptValue='What is this cloth , give the response in the following format {Cloth name , cloth color, upper wear or lower wear , Few word describing the uploaded cloth (like how it looks if it has some design or not ect) }, give only format answer , no other text, refrain using comma in the description';

  // File?
   getdata(image,promptValue)async{
     setState(() {
       scanning=true;
       mytext='';
     });

     try{

       List<int> imageBytes = File(image.path).readAsBytesSync();
       String base64File = base64.encode(imageBytes);
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mytext)));
       final data={
         "contents": [
           {
             "parts": [

               {"text":promptValue},

               {
                 "inlineData": {
                   "mimeType": "image/jpeg",
                   "data": base64File,
                 }
               }
             ]
           }
         ],
       };

       await http.post(Uri.parse(apiUrl),headers: header,body: jsonEncode(data)).then((response)async{

         if(response.statusCode==200){

           var result=jsonDecode(response.body);
           mytext=result['candidates'][0]['content']['parts'][0]['text'];
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mytext)));
           print(mytext);
           print(mytext.runtimeType);


           Map<String, dynamic> clothData = {

              'timestamp':Timestamp.now(),
             'type': mytext.split(',')[0].substring(2, mytext.split(',')[0].length), // Extract cloth type from response
             'color': mytext.split(',')[1], // Extract color from response
             'classification': mytext.split(',')[2], // Extract classification from response
             'description': mytext.split(',').last.substring(0,mytext.split(',').last.length-1), // Extract classification from response
             'imageUrl': await uploadImage(image), // Upload image and get URL (see below)
           };
           await firestore.collection('clothes').add(clothData);
           // print(mytext);
           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mytext)));


         }else{
           mytext='Response status : ${response.statusCode}';
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mytext)));

           print(mytext);
         }

       }).catchError((error){
         print('Error occored ${error}');
       });
     }catch(e){
       print('Error occured ${e}');
     }

     scanning=false;

     setState(() {});
  }
  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() =>this.image = tempImage);
    }on PlatformException catch(e){
      print('Failed to pick image: $e');
    }

  }
  Future<String> uploadImage(File image) async {
    // You can replace this with your preferred image storage solution
    // Here's an example using Firebase Storage (replace with your implementation)
    final storageRef = FirebaseStorage.instance.ref().child('clothes/${image.path.split('/').last}');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top:57 ),
            child: Row(
              children: [
                Container(

                  width: 45,
                  height: 43,
                  child: Image.asset('assets/Logobig.png'),
                ),
                Container(
                  child: Text("stylesnaps",style: TextStyle (
                      fontSize: 30,
                      fontFamily: 'Poppins'

                  ),),
                ),

              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top:127,left:18,right: 18),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Home',style:AppWidget.boldTextFeildStyle()),

                      Container(
                        width: 110,height: 27,
                        child: TextField(


                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),

                            decoration:InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Seach',

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23)
                                )
                            )

                        ),
                      )

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Text('Tips',textAlign: TextAlign.start,style: TextStyle(
                        fontSize: 15
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 155,
                        width: 109,
                        child: TextButton(
                          child: Text('Find Your Signature Style: Experiment with various styles to discover what makes you feel confident'),
                          style: AppWidget.tipsFeildStyle(),
                          onPressed: (){},),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 155,
                        width: 109,
                        child: TextButton(
                          child: Text('Invest in Quality Basics: Build a versatile wardrobe with quality basics like a well-fitted blaze'),
                          style: AppWidget.tipsFeildStyle(),
                          onPressed: (){},),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 155,
                        width: 109,
                        child: TextButton(
                          child: Text('Accessorize Thoughtfully: Elevate any outfit with carefully chosen accessories'),
                          style: AppWidget.tipsFeildStyle(),
                          onPressed: (){},),
                      ),

                    ],
                  ),
                  AppWidget.SizeBox(15.0),
                  Divider(),
                  AppWidget.SizeBox(15.0),
                  SizedBox(
                    child: TextButton(
                      child: Text("Camera"),
                      onPressed: ()=> pickImage(),
                    ),
                  ),
                  image!=null ? Image.file(image!): Image.asset('assets/Logobig.png'),

                  SizedBox(
                    child: TextButton(
                      child: Text("Add to Database"),
                      onPressed: (){
                        getdata(image!, promptValue);

                      },
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      child: Text("test"),
                      onPressed: (){
                        Navigator.pushNamed(context, 'wardrobe');

                      },
                    ),
                  ),
                  TextButton(onPressed: ()async{
                    await FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signed Out')));
                    Navigator.pushNamed(context, 'login');


                  }, child: Text('SIgnOUT'))







                ],

              ),
            ),
          )

        ],
      )
    );

  }
  // void showImagePickerOption(BuildContext context){
  //   showModalBottomSheet(context: context, builder: (builder){
  //
  //   });
  //
  // }
}

