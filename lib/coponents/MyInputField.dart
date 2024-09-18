import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'darkMode.dart';


class MyInput extends StatelessWidget {

   final String title ;
   final String hint ;
   final List<TextInputFormatter>? inputFormatters ;
   final bool color ;
   final bool readOnly ;
   final TextEditingController ? controller ;
   final Widget ? widget;
  
  const MyInput({Key? key , 

  required this.title,
  required this.hint,
  this.controller,
  this.widget,
  this.inputFormatters,

  required this.color ,
  required this.readOnly ,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:GoogleFonts.cairo( textStyle:  TextStyle(
              fontSize:  14,
              fontWeight: FontWeight.w600,
              color: color ?Themes.dark_white : Themes.light.primaryColor


            )
            ),
          ),

          Container(
            height: 48,
           
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(right: 14 , left: 14),
             decoration: BoxDecoration(
                color: color ?  Themes.dark_primary : Colors.grey[300],
               border: Border.all(
                 color:  color ?  Themes.dark_white : Themes.light.primaryColor,
                 width: 1
               ),
               borderRadius: BorderRadius.circular(5)
             ),
             child: Row(
               children:[
                  Expanded(
                 child: TextFormField(
                    inputFormatters: inputFormatters ,
                    //  [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),],
                   readOnly: readOnly,
                   autofocus: false,
                   cursorColor: color ?Themes.dark_white : Themes.light.primaryColor,
                   controller: controller,
                   style:  GoogleFonts.cairo( textStyle:TextStyle( fontSize: 14 ,  fontWeight: FontWeight.w400,height: 1.4 ,
                    color: color ? Themes.dark_white :Themes.light_black)),
                   decoration: InputDecoration(
                     hintText: hint,
                     hintStyle:TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Color.fromARGB(255, 206, 47, 35)),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),  
                   ),
                 )
               ),

               widget == null ? Container() : Container(child: widget,)
               ] 
             ),
          )
        ],),
    );
  }
}