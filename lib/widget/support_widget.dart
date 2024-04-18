import 'package:flutter/material.dart';
class AppWidget{
  static TextStyle boldTextFeildStyle(){
    return TextStyle(
        fontSize: 30,
        fontFamily: 'Poppins'
    );
  }
  static ButtonStyle tipsFeildStyle(){
    return ButtonStyle(

        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),

            )
        )
    );
  }
  static SizedBox SizeBox(width){
    return SizedBox(
      height: width,
    );
  }
  static TextStyle boldTextStyle(size,r,g,b,opacity){
    return TextStyle(
      fontSize:size,
      fontFamily: 'Poppins',
      color: Color.fromRGBO(r, g, b, opacity)

    );
  }
}
