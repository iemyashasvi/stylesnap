import 'package:flutter/material.dart';
import 'package:stylesnap/widget/support_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                )
              ],
            ),
          )

        ],
      )
    );

  }
}

