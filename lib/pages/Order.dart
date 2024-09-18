import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;

class order extends StatefulWidget {
  order({Key? key}) : super(key: key);

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  final _Storage = GetStorage();
  var _color = true;
  bool net = false;
  List orderJson = [];
  bool visible_ = false;
  String code = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    code = _Storage.read("code");
    token = _Storage.read("token");

    order();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: net == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                      visible: visible_,
                      child: Container(
                        // margin: EdgeInsets.only(top: 25),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  // Visibility(
                  //   visible: !visible_,
                  //   child: Center(
                  //     child: Image.asset(
                  //       'assets/net.png',
                  //       width: 200,
                  //     ),
                  //   ),
                  // ),
                  Visibility(
                    visible: !visible_,
                    child: Center(
                      child: Text(
                        "خطأ في الاتصال بالانترنت",
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: Themes.light.primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !visible_,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            order();
                            // net = false;
                            visible_ = true;
                          });
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 40,
                          color: Themes.light.primaryColor,
                        )),
                  )
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Visibility(
                        visible: visible_,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Themes.light.primaryColor),
                          )),
                        )),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: Themes.light.primaryColor,
                      onRefresh: order,
                      child: ListView.builder(
                          itemCount: orderJson.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(

                             
                                onTap: () {
                                 details_order(i);
                                 
                                },
                                child: _cardOrder(context, i));
                          }),
                    ),
                  ),
                ],
              ));
  }

  _cardOrder(context, index) {
    double _width = MediaQuery.of(context).size.width;

    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _color == true ? Themes.dark_primary : Themes.light_white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: _color == true ? Themes.dark_grey : Themes.light_white,
                width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 160,
                        child: Text(
                          orderJson[index]['note'].toString() == "null" ? "" : orderJson[index]['note'].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _color == true
                                    ? Themes.dark_white
                                    : Themes.light_grey),
                          ),
                        ),
                      ),
                    ]),
                    Column(children: [
                      Row(children: [
                        Text(
                          orderJson[index]['packagePrice'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _color == true
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor),
                        ),
                        Text(
                          "د.ل",
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Themes.light_grey)),
                        ),
                      ]),
                      Container(
                        width: 100,
                        child: Text(
                          orderJson[index]['cityName'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Themes.light_grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ]),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Container(
                        width: _width / 4,
                        child: Text(
                          orderJson[index]['recieverPhone1'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _color == true
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor),
                        ),
                      ),
                      Container(
                        width: _width / 4,
                        child: Text(
                          orderJson[index]['recieverPhone2'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Themes.light_grey),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: _width / 2 - 30,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Themes.light.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                    orderJson[index]['isSupplierRequest'].toString() == "true" ? "طلب مندوب" : "قيد الإنتظار",

                       
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                          color: Themes.light_white,
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  ///////////////////////////api order ///////////////////////////////////////////////

  Future<void> order() async {
    try {
      visible_ = true;
      var urlOrder = Uri.parse(api().url + api().order);
      var response = await http.get(
        urlOrder,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);
      setState(() {
        orderJson = responsebody['data'];
      });

      if (response.statusCode == 200) {
        visible_ = false;
        net = false;
      }
    } on SocketException {
      setState(() {
        visible_ = false;
        net = true;
      });
    } catch (ex) {
       visible_ = false;
    }
  }

  details_order(index) {
    Navigator.pushNamed(context, 'details_order',
        arguments: orderJson[index]['id']);
  }
}
