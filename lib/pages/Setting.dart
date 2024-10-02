import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/Login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';


class setting extends StatefulWidget {
  setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  var _value = false;
  String userId = "";
  String local = "false";
  final _Storage = GetStorage();
  var token = "";


  @override
  void initState() {
    super.initState();
    _value = _Storage.read("isDarkMode");
    userId = _Storage.read("userId").toString();
    token = _Storage.read("token");

  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: _value ? Themes.dark_primary : Themes.light_primary,
        body: Column(
          children: [

            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
                FirebaseMessaging.instance.unsubscribeFromTopic(userId);
                _Storage.remove("token");
                _Storage.remove("userId");
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      _value == true ? Themes.dark_primary : Themes.light_white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _value == true
                          ? Themes.dark_grey
                          : Themes.light_white,
                      width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                              "تسجيل الخروج",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _value == true
                                          ? Themes.dark_white
                                          : Themes.light.primaryColor)),
                            ),
                          ),
                          Container(
                            height: 35,
                            child: Transform.scale(
                              scale: 1,
                              child: Icon(
                                Icons.exit_to_app,
                                color: Themes.light.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

             GestureDetector(
              onTap: () {
                setState(() {
                  // deleteA();

                    Alert(
      context: context,
      // style: alertStyle,
      type: AlertType.error,
     title: "حذف الحساب",
       desc: "هل تريد حذف الحساب بالفعل",
      buttons: [
        DialogButton(
          child: Text(
            "موافق",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            deleteA();
            Navigator.pop(context);
          },
          color: Themes.light.primaryColor,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  
    //               Alert(
    //   context: context,
    //   title: "حذف الحساب",
    //   desc: "هل تريد حذف الحساب بالفعل",
    // ).show();
                });
               
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      _value == true ? Themes.dark_primary : Themes.light_white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _value == true
                          ? Themes.dark_grey
                          : Themes.light_white,
                      width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                              "تغيير كلمة المرور ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _value == true
                                          ? Themes.dark_white
                                          : Themes.light.primaryColor)),
                            ),
                          ),
                          Container(
                            height: 35,
                            child: Transform.scale(
                              scale: 1,
                              child: Icon(
                                Icons.change_circle_outlined,
                                color: Themes.light.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ));
  }

    ///////////////////////////api add ///////////////////////////////////////////////

  Future<void> deleteA() async {
    try {
           
        var urlAdd = Uri.parse(api().url + api().DeleteAccount);
        var response = await http.delete(
          urlAdd,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "content-type": "application/json"
          },
        );
        var responsebody = jsonDecode(response.body);
        if (response.statusCode == 200) {

               ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
             responsebody['message'].toString(),
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));

        }
  
    } on SocketException {

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          ))
          );
    } catch (ex) {
    }
  }

}
