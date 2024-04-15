// import 'dart:html';
import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylesnap/widget/support_widget.dart';
import 'package:http/http.dart' as http;


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
  String promptValue='Indentify the type of cloth and its color in a line also classify this as upperwear or bottomwear';

  // File?
   getdata(image,promptValue)async{
     setState(() {
       scanning=true;
       mytext='';
     });

     try{

       List<int> imageBytes = File(image.path).readAsBytesSync();
       String base64File = base64.encode(imageBytes);

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

       await http.post(Uri.parse(apiUrl),headers: header,body: jsonEncode(data)).then((response){

         if(response.statusCode==200){

           var result=jsonDecode(response.body);
           mytext=result['candidates'][0]['content']['parts'][0]['text'];
           // print(mytext);
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mytext)));


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
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
                        child: Text('Tip1'),
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
                        child: Text('Tip2'),
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
                        child: Text('Tip3'),
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
                Container(
                  child: Text("hy"),
                ),
                SizedBox(
                  child: TextButton(
                    child: Text("get answer"),
                    onPressed: ()=> getdata(image!, promptValue),
                  ),
                ),






              ],

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

