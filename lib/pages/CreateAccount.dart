import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/data/models/signUp_request_model.dart';
import 'package:pro_delivery/network/config_network.dart';
import 'package:pro_delivery/network/web_services.dart';
import 'package:pro_delivery/widgets/button/button.dart';
import 'dart:ui' as ui;
import 'package:pro_delivery/widgets/text_field/text_field.dart';

class createAccount extends StatefulWidget {
  createAccount({Key? key}) : super(key: key);

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  var First_name = TextEditingController();
  var Last_name = TextEditingController();
  var address = TextEditingController();
  var User_Name = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Themes.light_primary,
        appBar: _appBar(),
        body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                    child: Column(children: [
                  AppTextField(
                    title: 'الأسم الأول',
                    hint: 'أدخل الأسم',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: First_name,
                    required: true,
                  ),
                  AppTextField(
                    title: 'اللقب',
                    hint: 'أدخل اللقب',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: Last_name,
                    required: true,
                  ),
                  AppTextField(
                    title: 'العنوان',
                    hint: 'أدخل العنوان',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: address,
                    required: true,
                  ),
                  AppTextField(
                    title: 'أسم المستخدم',
                    hint: 'ادخل أسم المستخدم',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: User_Name,
                    required: true,
                  ),
                  AppTextField(
                    title: 'رقم الهاتف',
                    hint: 'أدخل رقم الهاتف',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: phone,
                    onValidate: (v) {
                      RegExp regex = RegExp(r'^09\d{8}$');
                      if (!regex.hasMatch(v ?? '')) {
                        return 'يجب أن يتكون رقم الهاتف من 10 أرقام ويبدأ بـ09';
                      }
                      return null;
                    },
                  ),
                  AppTextField(
                    title: 'الرقم السري',
                    hint: 'أدخل الرقم السري',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: password,
                    required: true,
                  ),
                  AppButton(
                      text: 'اضافة طلب',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          add();
                        }
                      })
                ])),
              ),
            )));
  }

  _appBar() {
    return AppBar(
      backgroundColor: Themes.light.primaryColor,
      actions: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              // child: Image.asset(
              //   api().urlIcon,
              //   height: 50,
              //   width: 47,
              //   fit: BoxFit.cover,
              // ),
            )),
      ],
    );
  }

  ///////////////////////////api add ///////////////////////////////////////////////
  Future<void> add() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      final response = await webServices.signUp(
          request: SignUpRequest(
        firstName: First_name.text,
        lastName: Last_name.text,
        address: address.text,
        userName: User_Name.text,
        phoneNumber: phone.text,
        password: password.text,
      ));

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "تم عمل حساب بنجاح",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
      Navigator.pop(context);
    } on SocketException {
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
      print(ex);
    }
  }
}
