import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/data/models/branch_model.dart';
import 'package:pro_delivery/data/models/city_model.dart';
import 'package:pro_delivery/network/config_network.dart';
import 'package:pro_delivery/network/web_services.dart';
import 'package:dio/dio.dart';
import 'package:pro_delivery/widgets/button/button.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pro_delivery/widgets/picker/picker_field.dart';
import 'package:pro_delivery/widgets/text_field/text_field.dart';

class addOrder extends StatefulWidget {
  addOrder({Key? key}) : super(key: key);

  @override
  State<addOrder> createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  final descriptionController = TextEditingController();
  final countOfItems = TextEditingController();
  final orderPrice = TextEditingController();
  final recipientPhoneNo = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String cityId = '';
  String branchId = '';

  List<BranchModel> branche = [];
  List<CityModel> cities = [];

  @override
  void initState() {
    super.initState();
    getBranches();
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
                  AppPicker(
                      title: 'الفرع',
                      hintText: 'اختر الفرع',
                      isExpanded: true,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      items: branche.map((e) => PickerModel(id: e.branchId, name: e.branchName)).toList(),
                      onChanged: (value) {
                        setState(() {
                          branchId = value!;
                        });

                        getCities();

                      }),
                  AppPicker(
                      title: 'المدينة',
                      hintText: 'المدينة',
                      isExpanded: true,
                      items: cities.map((e) => PickerModel(id: e.cityId, name: e.name)).toList(),
                      onChanged: (value) {
                        setState(() {
                          cityId = value!;
                        });
                      }),
                  AppTextField(
                    title: 'رقم الهاتف',
                    hint: 'ادخل رقم هاتف المستلم',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: recipientPhoneNo,
                  ),
                  AppTextField(
                    title: 'السعر',
                    hint: 'ادخل السعر',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: orderPrice,
                  ),
                  AppTextField(
                    title: 'عدد القطع',
                    hint: 'ادخل عدد القطع',
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: countOfItems,
                  ),
                  AppTextField(
                    title: 'الوصف',
                    hint: 'ادخل الوصف',

                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    controller: descriptionController,
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
              child: Image.asset(
                api().urlIcon,
                height: 50,
                width: 47,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  ///////////////////////////api BranchesAndCity ///////////////////////////////////////////////

  Future<void> getBranches() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      var response = await webServices.branches();
      setState(() {
        branche = response.branches;
      });
    } on DioException catch (ex) {
      setState(() {});
    } catch (ex) {}
  }

  Future<void> getCities() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      var response = await webServices.citiesByBranch(branchId: branchId);
      setState(() {
        cities = response.content.first.cities ?? [];
      });
    } on DioException catch (ex) {
      setState(() {});
    } catch (ex) {}
  }

  ///////////////////////////api add ///////////////////////////////////////////////
  Future<void> add() async {
    final webServices = WebServices(NetworkConfig.config());
    final response = await webServices.addOrder(
        branchId: branchId,
        cityId: cityId,
        recipientPhoneNo: recipientPhoneNo.text,
        orderPrice: orderPrice.text,
        countOfItems: countOfItems.text,
        description: descriptionController.text);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Themes.showSnackBarColor,
        content: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Text(
            "تمت الاضافة بنجاح",
            style: GoogleFonts.cairo(textStyle: TextStyle(fontSize: 14, color: Themes.light_white)),
          ),
        )));
    Navigator.pop(context);

    try {} on SocketException {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(textStyle: TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {}
  }
}
