import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylesnap/widget/support_widget.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String emaillogin="";
  String passlogin="";
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passcontroller=new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  login()async{
    if (emaillogin!=null && passlogin!=null && emailcontroller.text!=null && passcontroller.text!=null){
      try{final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emaillogin,
          password: passlogin

      );
      User? user = FirebaseAuth.instance.currentUser;

      bool isEmailverified=false;
      isEmailverified=FirebaseAuth.instance.currentUser!.emailVerified;
      if (isEmailverified){


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signed In')));
      Navigator.pushNamed(context, 'homescreen');}
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verify Your Email and Try again')));
      }

      }on FirebaseAuthException catch (e){
        if (e.code == 'user-not-found'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Not found')));

        }else if(e.code == 'invalid-credential'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password or email')));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));

        }
      }
    }

  }
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
               child: Form(
                 key:_formkey,
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
                        TextFormField(
                            validator: (value){
                              if (value==null||value.isEmpty){
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            controller: emailcontroller,
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
                        TextFormField(
                            validator: (value){
                              if (value==null||value.isEmpty){
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                            controller: passcontroller,
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
                              height: MediaQuery.of(context).size.height* .07,

                              width: MediaQuery.of(context).size.width* .87,
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
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        emaillogin=emailcontroller.text;
                                        passlogin=passcontroller.text;

                                      });
                                    }
                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Checker')));

                                    login();

                                    // Navigator.pushNamed(context, 'signup');
                                  }),
                            ),
                            Divider(),

                          ],
                        ),
                        AppWidget.SizeBox(15.0),

                        Divider(),
                        AppWidget.SizeBox( MediaQuery.of(context).size.height* .25,),
                        Container(
                          child: TextButton(
                            child: Text("Not a User ? Signup"),
                            onPressed:(){
                              Navigator.pushNamed(context, 'signup');
                            } ,
                          ),
                        )

                      ],
                   )
                 ),
               ),
             )
           ],
        ),
    );
  }
}
