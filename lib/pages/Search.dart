// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pro_delivery/coponents/Api.dart';
// import 'package:pro_delivery/coponents/MyButton.dart';
// import 'package:pro_delivery/coponents/MyInputField.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;
//
// import 'package:pro_delivery/coponents/darkMode.dart';
// import 'package:pro_delivery/pages/TabsOrder.dart';
//
// class search extends StatefulWidget {
//   search({Key? key}) : super(key: key);
//
//   @override
//   State<search> createState() => _searchState();
// }
//
// class _searchState extends State<search> {
//   Widget currenScreen = tabsorder();
//
//   DateTime from = DateTime.parse("2020-06-11");
//   DateTime to = DateTime.now();
//
//   final _Storage = GetStorage();
//
//   var _color = false;
//   bool visible_lodding = false;
//   bool visible_body = false;
//   bool visible_branch_lodding = false;
//   bool visible_branch = true;
//   bool visible_city_lodding = false;
//   bool visible_city = true;
//   var cityID = "";
//   var fromBranchID = "";
//   var fromBranchName = "";
//   var statusesID = "";
//   var statusesName = "";
//
//   var cityName = "";
//   var token = "";
//
//   List<dynamic> branche = [];
//   List<dynamic> statuses = [];
//   List<dynamic> dlyPrices = [];
//   List orderJson = [];
//
//   var barCode = TextEditingController();
//   var recieverPhone1 = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _color = _Storage.read("isDarkMode");
//     token = _Storage.read("token");
//     //     fromBranchID =   _Storage.read("fromBranchID").toString();
//     // fromBranchName = _Storage.read("fromBranchName").toString();
//     Branches();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
//       appBar: _appBar(),
//       body: Directionality(
//           textDirection: ui.TextDirection.rtl,
//           child: Container(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: SingleChildScrollView(
//                   child: Column(children: [
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: MyInput(
//                         controller: barCode,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//                         ],
//                         readOnly: false,
//                         color: _color,
//                         title: "كود الطرد",
//                         hint: "",
//                       ),
//                     ),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Expanded(
//                       child: MyInput(
//                         controller: recieverPhone1,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//                         ],
//                         readOnly: false,
//                         color: _color,
//                         title: "رقم المستلم",
//                         hint: "",
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 /////// ------------ DropdownSearch statuses ------------ ////////
//                 Visibility(
//                   visible: visible_branch,
//                   child: Container(
//                     margin: EdgeInsets.only(top: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "الحالات",
//                           style: GoogleFonts.cairo(
//                             textStyle: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: _color
//                                     ? Themes.dark_white
//                                     : Themes.light.primaryColor),
//                           ),
//                         ),
//                         Container(
//                           height: 52,
//                           margin: EdgeInsets.only(top: 8.0),
//                           padding: EdgeInsets.only(right: 14),
//                           decoration: BoxDecoration(
//                               color: _color
//                                   ? Themes.dark_primary
//                                   : Colors.grey[300],
//                               border: Border.all(
//                                   color: _color
//                                       ? Themes.dark_white
//                                       : Themes.light.primaryColor,
//                                   width: 1.0),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Row(children: [
//                             Expanded(
//                               child: DropdownSearch<String>(
//                                 // autoFocusSearchBox: true,
//
//
//
//                                 enabled: true,
//                                 popupProps: PopupProps.dialog(),
//
//
//                                 // popupProps: PopupProps.dialog(),
//                                 //to show search box
//                                 // enabled: true,
//                                 //list of dropdown items
//                                 //  dropdownBuilder: _style,
//                                 dropdownBuilder: _customDropDownAddress,
//                                 items: List<String>.from(
//                                     statuses.map((e) => e['name'])),
//                                 // label: "Country",
//                                 onChanged: (value) {
//                                   for (var i = 0; i < statuses.length; i++) {
//                                     if (statuses[i]['name'] == value) {
//                                       this.statusesID = statuses[i]['id'];
//                                       this.statusesName = statuses[i]['name'];
//                                     }
//                                   }
//                                   setState(() {});
//                                 },
//
//                                 //show selected item
//                                 selectedItem: this.fromBranchName,
//                               ),
//                             ),
//                           ]),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//
// /////// ------------ DropdownSearch branch ------------ ////////
//
//                 Visibility(
//                     visible: visible_branch_lodding,
//                     child: Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: Center(
//                           child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                             Themes.light.primaryColor),
//                       )),
//                     )),
//
//                 Visibility(
//                   visible: visible_branch,
//                   child: Container(
//                     margin: EdgeInsets.only(top: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "المكتب",
//                           style: GoogleFonts.cairo(
//                             textStyle: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: _color
//                                     ? Themes.dark_white
//                                     : Themes.light.primaryColor),
//                           ),
//                         ),
//                         Container(
//                           height: 52,
//                           margin: EdgeInsets.only(top: 8.0),
//                           padding: EdgeInsets.only(right: 14),
//                           decoration: BoxDecoration(
//                               color: _color
//                                   ? Themes.dark_primary
//                                   : Colors.grey[300],
//                               border: Border.all(
//                                   color: _color
//                                       ? Themes.dark_white
//                                       : Themes.light.primaryColor,
//                                   width: 1.0),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Row(children: [
//                             Expanded(
//                               child: DropdownSearch<String>(
//                                 // autoFocusSearchBox: true,
//
//
//                                 enabled: true,
//                                 popupProps: PopupProps.dialog(),
//
//
//                                 // popupProps: PopupProps.dialog(),
//                                 //to show search box
//                                 // enabled: true,
//                                 //list of dropdown items
//                                 //  dropdownBuilder: _style,
//                                 dropdownBuilder: _customDropDownAddress,
//                                 items: List<String>.from(
//                                     branche.map((e) => e['name'])),
//                                 // label: "Country",
//                                 onChanged: (value) {
//                                   for (var i = 0; i < branche.length; i++) {
//                                     if (branche[i]['name'] == value) {
//                                       this.fromBranchID = branche[i]['id'];
//                                       this.fromBranchName = branche[i]['name'];
//                                     }
//                                   }
//                                   setState(() {
//                                     visible_city_lodding = true;
//                                     visible_city = false;
//
//                                     delivery_Prices();
//                                   });
//                                 },
//
//                                 //show selected item
//                                 selectedItem: this.fromBranchName,
//                               ),
//                             ),
//                           ]),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//
// /////// ------------ DropdownSearch city ------------ ////////
//                 Visibility(
//                     visible: visible_city_lodding,
//                     child: Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: Center(
//                           child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                             Themes.light.primaryColor),
//                       )),
//                     )),
//                 Visibility(
//                   visible: visible_city,
//                   child: Container(
//                     margin: EdgeInsets.only(top: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "المدينة",
//                           style: GoogleFonts.cairo(
//                             textStyle: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: _color
//                                     ? Themes.dark_white
//                                     : Themes.light.primaryColor),
//                           ),
//                         ),
//                         Container(
//                           height: 52,
//                           margin: EdgeInsets.only(top: 8.0),
//                           padding: EdgeInsets.only(right: 14),
//                           decoration: BoxDecoration(
//                               color: _color
//                                   ? Themes.dark_primary
//                                   : Colors.grey[300],
//                               border: Border.all(
//                                   color: _color
//                                       ? Themes.dark_white
//                                       : Themes.light.primaryColor,
//                                   width: 1.0),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Row(children: [
//                             Expanded(
//                               child: DropdownSearch<String>(
//
//                                 enabled: true,
//                                 popupProps: PopupProps.dialog(),
//
//
//                                 // popupProps: PopupProps.dialog(),
//                                 //to show search box
//                                 // enabled: true,
//                                 //list of dropdown items
//                                 //  dropdownBuilder: _style,
//                                 dropdownBuilder: _customDropDownAddress,
//                                 items: List<String>.from(
//                                     dlyPrices.map((e) => e['name'])),
//                                 // label: "Country",
//                                 onChanged: (value) {
//                                   for (var i = 0; i < dlyPrices.length; i++) {
//                                     if (dlyPrices[i]['name'] == value) {
//                                       this.cityID = dlyPrices[i]['id'];
//                                       this.cityName = value.toString();
//                                     }
//                                   }
//                                 },
//
//                                 //show selected item
//                                 selectedItem: this.cityName,
//                               ),
//                             ),
//                           ]),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     /////////////////////// من تاريخ ///////////////////////////
//
//                     Expanded(
//                         child: Container(
//                       margin: EdgeInsets.only(top: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "من تاريخ",
//                             style: GoogleFonts.cairo(
//                                 textStyle: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: _color
//                                         ? Themes.dark_white
//                                         : Themes.light.primaryColor)),
//                           ),
//                           Container(
//                             height: 42,
//                             margin: EdgeInsets.only(top: 8.0),
//                             padding: EdgeInsets.only(right: 14),
//                             decoration: BoxDecoration(
//                                 color: _color
//                                     ? Themes.dark_primary
//                                     : Colors.grey[300],
//                                 border: Border.all(
//                                     color: _color
//                                         ? Themes.dark_white
//                                         : Themes.light.primaryColor,
//                                     width: 1),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(children: [
//                               Expanded(
//                                   child: TextFormField(
//                                 readOnly: true,
//                                 autofocus: false,
//                                 cursorColor: _color
//                                     ? Themes.dark_white
//                                     : Themes.light.primaryColor,
//                                 style: GoogleFonts.cairo(
//                                     textStyle: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.4,
//                                         color: _color
//                                             ? Themes.dark_white
//                                             : Themes.light_black)),
//                                 decoration: InputDecoration(
//                                   icon: GestureDetector(
//                                     onTap: () {
//                                       _getDateFromUser(context);
//                                     },
//                                     child: Icon(
//                                       Icons.calendar_today_rounded,
//                                       color: _color
//                                           ? Themes.dark_white
//                                           : Themes.light.primaryColor,
//                                     ),
//                                   ),
//                                   hintText:
//                                       DateFormat('yyyy-MM-dd').format(from),
//                                   hintStyle: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: _color
//                                           ? Themes.dark_white
//                                           : Themes.light_black),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.white,
//                                     width: 0,
//                                   )),
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.white,
//                                     width: 0,
//                                   )),
//                                 ),
//                               )),
//                             ]),
//                           )
//                         ],
//                       ),
//                     )),
//
//                     SizedBox(
//                       width: 12,
//                     ),
//
//                     /////////////////////// الى تاريخ ///////////////////////////
//
//                     Expanded(
//                         child: Container(
//                       margin: EdgeInsets.only(top: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "الى تاريخ",
//                             style: GoogleFonts.cairo(
//                                 textStyle: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: _color
//                                         ? Themes.dark_white
//                                         : Themes.light.primaryColor)),
//                           ),
//                           Container(
//                             height: 42,
//                             margin: EdgeInsets.only(top: 8.0),
//                             padding: EdgeInsets.only(right: 14),
//                             decoration: BoxDecoration(
//                                 color: _color
//                                     ? Themes.dark_primary
//                                     : Colors.grey[300],
//                                 border: Border.all(
//                                     color: _color
//                                         ? Themes.dark_white
//                                         : Themes.light.primaryColor,
//                                     width: 1),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(children: [
//                               Expanded(
//                                   child: TextFormField(
//                                 readOnly: true,
//                                 autofocus: false,
//                                 cursorColor: _color
//                                     ? Themes.dark_white
//                                     : Themes.light.primaryColor,
//                                 style: GoogleFonts.cairo(
//                                     textStyle: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.4,
//                                         color: _color
//                                             ? Themes.dark_white
//                                             : Themes.light_black)),
//                                 decoration: InputDecoration(
//                                   icon: GestureDetector(
//                                     onTap: () {
//                                       _getDateToUser(context);
//                                     },
//                                     child: Icon(
//                                       Icons.calendar_today_rounded,
//                                       color: _color
//                                           ? Themes.dark_white
//                                           : Themes.light.primaryColor,
//                                     ),
//                                   ),
//                                   hintText: DateFormat('yyyy-MM-dd').format(to),
//                                   hintStyle: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: _color
//                                           ? Themes.dark_white
//                                           : Themes.light_black),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.white,
//                                     width: 0,
//                                   )),
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.white,
//                                     width: 0,
//                                   )),
//                                 ),
//                               )),
//                             ]),
//                           )
//                         ],
//                       ),
//                     ))
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       Under_procedure();
//                     });
//                   },
//                   child: Container(
//                     alignment: Alignment.topCenter,
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Themes.light.primaryColor,
//                     ),
//                     child: Text(
//                       "بحث",
//                       style: GoogleFonts.cairo(
//                           textStyle: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 30,
//                 ),
//               ])))),
//     );
//   }
//
//   Widget _customDropDownAddress(BuildContext context, _addressFilteredName) {
//     return Container(
//         child: Text(_addressFilteredName.toString(),
//             style: GoogleFonts.cairo(
//                 textStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: _color ? Themes.dark_white : Themes.light_black))));
//   }
//
//   Widget _style1(BuildContext context, String? item, bool isSelected) {
//     return Directionality(
//       textDirection: ui.TextDirection.rtl,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: !isSelected
//               ? null
//               : BoxDecoration(
//                   border: Border.all(color: Theme.of(context).primaryColor),
//                   borderRadius: BorderRadius.circular(5),
//                   color: Themes.light.primaryColor,
//                 ),
//           child: Text(
//             item!,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.cairo(
//                 textStyle: TextStyle(
//                     fontSize: 15,
//                     fontWeight: isSelected ? FontWeight.bold : null,
//                     color: isSelected
//                         ? Themes.light_white
//                         : _color == true
//                             ? Themes.dark_white
//                             : Themes.light_black)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getDateFromUser(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//         context: context,
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//             data: ThemeData(
//               primarySwatch: Colors.grey,
//               splashColor: Color.fromARGB(255, 90, 66, 66),
//               textTheme: TextTheme(
//                 titleMedium: TextStyle(color: Colors.white),
//                 labelLarge: TextStyle(color: Colors.black),
//               ),
//               colorScheme: ColorScheme.light(
//                   primary: Themes.light.primaryColor,
//                   onSecondary: Colors.white,
//                   onPrimary: Colors.white,
//                   surface: Colors.white,
//                   onSurface: _color ? Colors.white : Colors.black,
//                   secondary: Colors.white),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   foregroundColor: _color
//                       ? Themes.dark_white
//                       : Themes.light.primaryColor, // button text color
//                 ),
//               ),
//               dialogBackgroundColor:
//                   _color ? Themes.dark_primary2 : Colors.white,
//             ),
//             child: child ?? Text(""),
//           );
//         },
//         initialDate: from,
//         firstDate: DateTime(1960, 8),
//         lastDate: DateTime.now());
//     if (picked != null && picked != from)
//       setState(() {
//         from = picked;
//       });
//   }
//
//   Future<void> _getDateToUser(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//         context: context,
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//             data: ThemeData(
//               primarySwatch: Colors.grey,
//               splashColor: Color.fromARGB(255, 90, 66, 66),
//               textTheme: TextTheme(
//                 titleMedium: TextStyle(color: Colors.white),
//                 labelLarge: TextStyle(color: Colors.black),
//               ),
//               colorScheme: ColorScheme.light(
//                   primary: Themes.light.primaryColor,
//                   onSecondary: Colors.white,
//                   onPrimary: Colors.white,
//                   surface: Colors.white,
//                   onSurface: _color ? Colors.white : Colors.black,
//                   secondary: Colors.white),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   foregroundColor: _color
//                       ? Themes.dark_white
//                       : Themes.light.primaryColor, // button text color
//                 ),
//               ),
//               dialogBackgroundColor:
//                   _color ? Themes.dark_primary2 : Colors.white,
//             ),
//             child: child ?? Text(""),
//           );
//         },
//         initialDate: to,
//         firstDate: DateTime(1960, 8),
//         lastDate: DateTime.now());
//     if (picked != null && picked != to)
//       setState(() {
//         to = picked;
//       });
//   }
//
//   _appBar() {
//     return AppBar(
//       backgroundColor: Themes.light.primaryColor,
//       actions: <Widget>[
//         Container(
//             margin: EdgeInsets.all(5),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: Image.asset(
//                 api().urlIcon,
//                 height: 50,
//                 width: 47,
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ],
//     );
//   }
//
// ///////////////////////////api Branches ///////////////////////////////////////////////
//
//   Future<void> Branches() async {
//     try {
//       visible_branch = false;
//       visible_branch_lodding = true;
//       var urlBranches = Uri.parse(api().url + api().StatusesAndBranches);
//       var response = await http.get(
//         urlBranches,
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//       var responsebody = jsonDecode(response.body);
//       setState(() {
//         branche = responsebody['data']['branches'];
//         statuses = responsebody['data']['statuses'];
//       });
//
//       if (response.statusCode == 200) {
//         visible_branch = true;
//         visible_branch_lodding = false;
//       }
//     } on SocketException {
//       setState(() {
//         visible_branch = true;
//         visible_branch_lodding = false;
//       });
//     } catch (ex) {
//       visible_branch = true;
//       visible_branch_lodding = false;
//     }
//   }
//
// ///////////////////////////api deliveryPrices ///////////////////////////////////////////////
//
//   Future<void> delivery_Prices() async {
//     try {
//       // visible_ = true;
//       var urlDeliveryPrices =
//           Uri.parse(api().url + api().GetCitiesAndBranches + fromBranchID);
//
//       var response = await http.get(
//         urlDeliveryPrices,
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//
//       var responsebody = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           dlyPrices = responsebody['data']['cities'];
//           branche = responsebody['data']['branches'];
//           this.cityID = dlyPrices[0]['id'];
//           this.cityName = dlyPrices[0]['name'];
//           visible_body = false;
//           visible_branch = true;
//           visible_branch_lodding = false;
//           visible_city = true;
//           visible_city_lodding = false;
//         });
//       }
//     } on SocketException {
//       setState(() {
//         // visible_ = false;
//       });
//
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: Themes.showSnackBarColor,
//           content: Directionality(
//             textDirection: ui.TextDirection.rtl,
//             child: Text(
//               "خطأ في الاتصال بالانترنت",
//               style: GoogleFonts.cairo(
//                   textStyle:
//                       TextStyle(fontSize: 14, color: Themes.light_white)),
//             ),
//           )));
//     } on FormatException {
//       setState(() {
//         visible_branch = true;
//         visible_branch_lodding = false;
//         visible_city = true;
//         visible_city_lodding = false;
//       });
//
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: Themes.showSnackBarColor,
//           content: Directionality(
//             textDirection: ui.TextDirection.rtl,
//             child: Text(
//               "يوجد خطأ في البيانات",
//               style: GoogleFonts.cairo(
//                   textStyle:
//                       TextStyle(fontSize: 14, color: Themes.light_white)),
//             ),
//           )));
//     } catch (ex) {
//       visible_branch = true;
//       visible_branch_lodding = false;
//       visible_city = true;
//       visible_city_lodding = false;
//     }
//   }
//
//   /////////////////////////// Under_procedure ///////////////////////////////////////////////
//
//   Future<void> Under_procedure() async {
//     try {
//       var body = {
//         "BarCode": this.barCode.text.toString(),
//         "recieverPhone1": this.recieverPhone1.text.toString(),
//         "CityId": this.cityID,
//         "StatusId": this.statusesID,
//         "From": DateFormat('yyyy-MM-dd').format(from),
//         "To": DateFormat('yyyy-MM-dd').format(to),
//       };
//       Navigator.pushNamed(context, 'searchIndex', arguments: body);
//     } catch (ex) {}
//   }
// }
