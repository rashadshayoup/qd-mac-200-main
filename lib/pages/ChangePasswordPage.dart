import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/data/models/change_password_request_model.dart';
import 'package:pro_delivery/network/config_network.dart';
import 'package:pro_delivery/network/web_services.dart';
import 'package:pro_delivery/widgets/button/button.dart';
import 'package:pro_delivery/widgets/text_field/text_field.dart';
import 'dart:ui' as ui;

import 'Login.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var confirmNewPassword = TextEditingController();
  var newPassword = TextEditingController();
  var oldPassword = TextEditingController();
  bool _isLoading = false;
  String userId = "";
  String local = "false";
  final _Storage = GetStorage();
  var token = "";

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userId = _Storage.read("userId").toString();
    token = _Storage.read("token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تغيير كلمة المرور'),
        centerTitle: true,
        backgroundColor: Themes.light.primaryColor,
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextField(
                      title: 'الرقم السري الحالي',
                      hint: 'أدخل الرقم السري  الحالي',
                      margin: EdgeInsets.symmetric(vertical: 10),
                      controller: oldPassword,
                      isPasswordField: true,
                      required: true,
                    ),
                    AppTextField(
                      title: 'الرقم السري الجديد',
                      hint: 'أدخل الرقم السري  الجديد',
                      margin: EdgeInsets.symmetric(vertical: 10),
                      isPasswordField: true,
                      controller: newPassword,
                      required: true,
                    ),
                    AppTextField(
                      title: 'تأكيد الرقم السري الجديد',
                      hint: 'أدخل الرقم السري  الجديد',
                      margin: EdgeInsets.symmetric(vertical: 10),
                      controller: confirmNewPassword,
                      required: true,
                      isPasswordField: true,
                      onValidate: (v) {
                        if (v != newPassword.text)
                          return 'كلمة المرور الجديدة غير مطابقة';
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton(
                            text: 'تغيير كلمة المرور',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                changePassword();
                              }
                            })
                  ],
                ),
              ),
            )),
      ),
    );
  }

  ///////////////////////////api add ///////////////////////////////////////////////
  Future<void> changePassword() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      setState(() {
        _isLoading = true;
      });
      final response = await webServices.changePassword(
          request: ChangePasswordRequest(
        oldPassWord: oldPassword.text,
        newPassWord: newPassword.text,
        confirmNewPassWord: confirmNewPassword.text,
      ));
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
      FirebaseMessaging.instance.unsubscribeFromTopic(userId);
      _Storage.remove("token");
      _Storage.remove("userId");
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "تم تغيير كلمة المرور بنجاح",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } on SocketException {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      setState(() {
        _isLoading = false;
      });
      print(ex);
    }
  }
}
