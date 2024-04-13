import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            child: Text('Sign Up',style: TextStyle(
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
                    Text(" Create Password" ,style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins'


                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        obscureText: true,
                        decoration:InputDecoration(

                            hintText: 'Must be 8 characters ',
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Confirm Password" ,style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins'


                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        obscureText: true,
                        decoration:InputDecoration(

                            hintText: 'Repeat Password ',
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
                              child:Text('Sign Up',style: TextStyle(fontSize: 16)),

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
