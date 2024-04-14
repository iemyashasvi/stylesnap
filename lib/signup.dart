import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name="";
  String email='';
  String pass="";
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController passcontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  final _formkey=GlobalKey<FormState>();

  registration()async{
    if (pass!=null && namecontroller.text!="" && emailcontroller.text!=""){
      try{
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered Successfully')));
      }on FirebaseAuthException catch(e){
        if (e.code=="weak-password"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Too weak Password')));
        }else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Already Exists')));

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
                child:Form(
                  key:_formkey,
                  child: Column(
                  
                    children: [
                  
                      Text("Name" ,style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins'
                  
                  
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          validator: (value){
                            if (value==null||value.isEmpty){
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          controller: namecontroller,
                          decoration:InputDecoration(
                              hintText: 'Enter Your Name ',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                  
                              hintText: 'Must be 8 characters ',
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
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      email=emailcontroller.text;
                                      pass=passcontroller.text;
                                      name=namecontroller.text;
                                    });
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Btn')));

                                  registration();



                                }),
                          )
                        ],
                      )
                  
                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
