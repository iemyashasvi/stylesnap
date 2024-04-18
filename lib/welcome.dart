import 'package:flutter/material.dart';
import 'package:stylesnap/widget/support_widget.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

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
          Padding(
            padding: EdgeInsets.only(left: 39),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Swipe \nRight on',style: AppWidget.boldTextStyle(48.0, 102, 102, 102, 1.0),
                ),
                // Text('Right on',style: AppWidget.boldTextStyle(48.0, 102, 102, 102, 1.0)
                // ),
                Text('Your Style.',style: AppWidget.boldTextStyle(48.0, 0, 0, 0, 1.0),
                ),
                Text('Love your \nclothes \nagain',style: AppWidget.boldTextStyle(48.0, 102, 102, 102, 1.0),
                ),
              ],

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(

              height: 75,
              width: 376,
              child: TextButton(
                child: Text('Get Started',
                style:TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pushNamed(context, 'login');
                },
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40.0)
              ),
            ),
          ),
        ],

      ),

    );
  }
}
