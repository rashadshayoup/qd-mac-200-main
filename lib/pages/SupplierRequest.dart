import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '../coponents/darkMode.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class supRequest extends StatefulWidget {
  supRequest({Key? key}) : super(key: key);

  @override
  State<supRequest> createState() => _supRequestState();
}

class _supRequestState extends State<supRequest> {
  final _Storage = GetStorage();
  bool hintV = false;
  var _color = false;
  List<dynamic> branche = [];
  List<dynamic> dlyPrices = [];
  var cityID = "";
  var fromBranchID = "";
  var fromBranchName = "";
  var cityName = "";

  var customerPhone1 = TextEditingController();
  var customerPhone2 = TextEditingController();
  var storeName = TextEditingController();
  var recieverPhone1 = TextEditingController();
  var recieverPhone2 = TextEditingController();
  var address = TextEditingController();
  var packagePrice = TextEditingController();
  var packageNumber = TextEditingController();
  var note = TextEditingController();
  var orderDescription = TextEditingController();

  var token = "";

  bool visible_lodding = false;
  bool visible_body = true;
  bool visible_branch_lodding = true;
  bool visible_branch = false;
  bool visible_city_lodding = false;
  bool visible_city = false;
  String phone1 = "";
  String phone2 = "";
  @override
  void initState() {
    super.initState();
    try {
      _color = _Storage.read("isDarkMode");
      token = _Storage.read("token");
      storeName.text = _Storage.read("storeName").toString();
      fromBranchID = _Storage.read("fromBranchID").toString();
      fromBranchName = _Storage.read("fromBranchName").toString();
      customerPhone1.text = _Storage.read("phone1").toString();
      customerPhone2.text = _Storage.read("phone2").toString() == "null"
          ? ""
          : _Storage.read("phone2").toString();
      if (_Storage.read("fromBranchID").toString() == "00") {
        BranchesAndCity();
      } else {
        delivery_Prices();
      }
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        appBar: _appBar(),
        body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Visibility(
                      visible: visible_lodding,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),

                  SizedBox(
                    height: 5,
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            readOnly: false,
                            color: _color,
                            controller: customerPhone1,
                            title: "رقم المرسل",
                            hint: hintV == false ? "" : "يجب الملء",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            readOnly: false,
                            controller: customerPhone2,
                            color: _color,
                            title: "رقم المرسل 2",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      readOnly: false,
                      color: _color,
                      controller: packageNumber,
                      title: "عدد الطلبيات",
                      hint: "",
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      readOnly: false,
                      color: _color,
                      controller: address,
                      title: "عنواني",
                      hint: "",
                    ),
                  ),

/////// ------------ DropdownSearch branch ------------ ////////

                  Visibility(
                      visible: visible_branch_lodding,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),

                  Visibility(
                    visible: visible_branch,
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المكتب",
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: _color
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: _color
                                        ? Themes.dark_white
                                        : Themes.light.primaryColor,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                  // autoFocusSearchBox: true,

                                  enabled: true,

                                  popupProps: PopupProps.dialog(),

                                  // popupProps: PopupProps.dialog(),
                                  //to show search box
                                  // enabled: true,
                                  // showSelectedItems: true,
                                  //list of dropdown items
                                  //  dropdownBuilder: _style,
                                  dropdownBuilder: _customDropDownAddress,
                                  // popupItemBuilder: _style1,
                                  items: List<String>.from(
                                      branche.map((e) => e['name'])),
                                  // label: "Country",
                                  onChanged: (value) {
                                    for (var i = 0; i < branche.length; i++) {
                                      if (branche[i]['name'] == value) {
                                        this.fromBranchID = branche[i]['id'];
                                        this.fromBranchName =
                                            branche[i]['name'];
                                      }
                                    }
                                    setState(() {
                                      visible_city_lodding = true;
                                      visible_city = false;

                                      delivery_Prices();
                                    });
                                  },

                                  //show selected item
                                  selectedItem: this.fromBranchName,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

/////// ------------ DropdownSearch city ------------ ////////
                  Visibility(
                      visible: visible_city_lodding,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  Visibility(
                    visible: visible_city,
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المدينة",
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: _color
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: _color
                                        ? Themes.dark_white
                                        : Themes.light.primaryColor,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                  enabled: true,
                                  popupProps: PopupProps.dialog(),

                                  // popupProps: PopupProps.dialog(),
                                  //to show search box
                                  // enabled: true,
                                  //list of dropdown items
                                  //  dropdownBuilder: _style,
                                  dropdownBuilder: _customDropDownAddress,
                                  items: List<String>.from(
                                      dlyPrices.map((e) => e['name'])),
                                  // label: "Country",
                                  onChanged: (value) {
                                    for (var i = 0; i < dlyPrices.length; i++) {
                                      if (dlyPrices[i]['name'] == value) {
                                        this.cityID = dlyPrices[i]['id'];
                                        this.cityName = value.toString();
                                      }
                                    }
                                  },

                                  //show selected item
                                  selectedItem: this.cityName,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Visibility(
                    visible: visible_body,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          hintV = true;
                          add();
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Themes.light.primaryColor,
                        ),
                        child: Text(
                          "ارسال",
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              )),
            )));
  }

  Widget _customDropDownAddress(BuildContext context, _addressFilteredName) {
    return Container(
        child: Text(_addressFilteredName.toString(),
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _color ? Themes.dark_white : Themes.light_black))));
  }

  Widget _style1(BuildContext context, String? item, bool isSelected) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: !isSelected
              ? null
              : BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Themes.light.primaryColor,
                ),
          child: Text(
            item!,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : null,
                    color: isSelected
                        ? Themes.light_white
                        : _color == true
                            ? Themes.dark_white
                            : Themes.light_black)),
          ),
        ),
      ),
    );
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

  Future<void> BranchesAndCity() async {
    try {
      var urlBranches = Uri.parse(api().url + api().Branches);
      var response = await http.get(
        urlBranches,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);

      setState(() {
        branche = responsebody['data'];
      });

      if (response.statusCode == 200) {
        fromBranchName = branche[0]['name'];
        fromBranchID = branche[0]['id'];

        var urlDeliveryPrices = Uri.parse(
            api().url + api().GetCitiesAndBranches + branche[0]['id']);

        var response_dly = await http.get(
          urlDeliveryPrices,
          headers: {
            "Authorization": "Bearer $token",
          },
        );

        var responsebody_dly = jsonDecode(response_dly.body);
        if (response.statusCode == 200) {
          setState(() {
            dlyPrices = responsebody_dly['data']['cities'];
            branche = responsebody_dly['data']['branches'];
            this.cityID = dlyPrices[0]['id'];
            this.cityName = dlyPrices[0]['name'];

            visible_branch = true;
            visible_branch_lodding = false;
            visible_city = true;
            visible_city_lodding = false;
          });
        }
      }
    } on SocketException {
      setState(() {
        visible_branch = true;
        visible_branch_lodding = false;
        visible_city = true;
        visible_city_lodding = false;
      });
    } catch (ex) {
      visible_branch = true;
      visible_branch_lodding = false;
      visible_city = true;
      visible_city_lodding = false;
    }
  }

  ///////////////////////////api deliveryPrices ///////////////////////////////////////////////

  Future<void> delivery_Prices() async {
    try {
      var urlDeliveryPrices =
          Uri.parse(api().url + api().GetCitiesAndBranches + fromBranchID);

      var response = await http.get(
        urlDeliveryPrices,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          dlyPrices = responsebody['data']['cities'];
          branche = responsebody['data']['branches'];
          this.cityID = dlyPrices[0]['id'];
          this.cityName = dlyPrices[0]['name'];

          visible_branch = true;
          visible_branch_lodding = false;
          visible_city = true;
          visible_city_lodding = false;
        });
      }
    } on SocketException {
      setState(() {});

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
    } on FormatException {
      setState(() {
        visible_branch = true;
        visible_branch_lodding = false;
        visible_city = true;
        visible_city_lodding = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "يوجد خطأ في البيانات",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      visible_branch = true;
      visible_branch_lodding = false;
      visible_city = true;
      visible_city_lodding = false;
    }
  }

  ///////////////////////////api add ///////////////////////////////////////////////

  Future<void> add() async {
    try {
      if (customerPhone1.text.isNotEmpty) {
        hintV = false;
        visible_lodding = true;
        visible_body = false;
        visible_city = false;
        visible_branch = false;
        var _body = {
          'customerPhone1': customerPhone1.text.toString(),
          'customerPhone2': customerPhone2.text.toString(),
          'address': address.text.toString(),
          'cityID': this.cityID,
          'fromBranchID': this.fromBranchID,
          'packageNumber': packageNumber.text.toString() == ""
              ? 1
              : packageNumber.text.toString(),
        };

        var urlAdd = Uri.parse(api().url + api().SupplierRequest);
        var response = await http.post(
          urlAdd,
          body: jsonEncode(_body),
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "content-type": "application/json"
          },
        );
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => homePagess()),
          );
          visible_lodding = false;
          visible_body = true;
        }
      } else {
        hintV = true;

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Text(
                "يجب الملء",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      }
    } on SocketException {
      visible_branch = true;
      visible_branch_lodding = false;
      visible_city = true;
      visible_city_lodding = false;

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
      visible_branch = true;
      visible_branch_lodding = false;
      visible_city = true;
      visible_city_lodding = false;
    }
  }
}
