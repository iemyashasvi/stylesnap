import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
           children: [ 
             Container(
               padding: EdgeInsets.only(left:50,top: 64),
               // decoration: BoxDecoration (image: AssetImage('assets/Logobig.png') )
               child: Text('StyleSnaps',style: TextStyle (
                 fontSize: 30,
                 fontFamily: 'Poppins'

               ),),



             ),
             Container(
               padding: EdgeInsets.only(left:20,top: 145),
               child: Text('Log In',style: TextStyle(
                 fontSize: 30,
                 fontFamily: 'Poppins'
               ),

               ),
             ),
             SingleChildScrollView(
               child: Container(
                   padding: EdgeInsets.only(left:20,
                     top:MediaQuery.of(context).size.height*0.26,
                     right: 20
                   ),
                   child:Column(

                    children: [

                      Text("Email" ,style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins'


                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration:InputDecoration(
                         hintText: 'Enter Your Email ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Password" ,style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins'


                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          obscureText: true,
                          decoration:InputDecoration(

                              hintText: 'Password ',
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10)
                              )
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height:56,
                            width: 353,
                            child: TextButton(
                                child:Text('Log in',style: TextStyle(fontSize: 16)),

                                style: ButtonStyle(

                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),

                                        )
                                    )
                                ),
                                onPressed:(){
                                  Navigator.pushNamed(context, 'signup');
                                }),
                          )
                        ],
                      )

                    ],
                 )
               ),
             )
           ],
        ),
    );
  }
}
