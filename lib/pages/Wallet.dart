import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'package:pro_delivery/data/models/order_model.dart';
import 'dart:ui' as ui;

import 'package:pro_delivery/network/web_services.dart';
import 'package:retrofit/dio.dart';

class wallet extends StatefulWidget {
  wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  final _Storage = GetStorage();
  var _color = true;
  bool net = false;
  bool visible_ = false;
  String code = "";
  String token = "";
  String name = "";
  List<OrderModel> _transactions = [];

  String? _balance;

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token").toString();

    _fetchWalletTransactions();
    _fetchWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: SafeArea(
            child: net == true
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
                                _fetchWalletTransactions();
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
                        padding: const EdgeInsets.only(top: 25),
                        child: _cardCash(context),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          color: Themes.light.primaryColor,
                          onRefresh: _fetchWalletTransactions,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _transactions.length,
                              itemBuilder: (context, i) {
                                return _cardOrder(context, _transactions[i]);
                              }),
                        ),
                      ),
                    ],
                  )));
  }

  _cardCash(context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              width: _width - 40,
              decoration: BoxDecoration(
                  color: Themes.light.primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "رصيدك الحالي هو ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "د.ل ",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          _balance ?? '-',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ))
      ],
    );
  }

  Widget _cardOrder(BuildContext context, OrderModel model) {
    double _width = MediaQuery.of(context).size.width;

    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");

    return Container(
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
                Container(
                  width: 100,
                  child: Text(
                    model.recipientAddress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Themes.light_grey,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(children: [
                  Text(
                    model.orderPrice.toString(),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الطلبية',
                    ),
                    Container(
                      width: _width / 4,
                      child: Text(
                        model.orderNo,
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
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: _width / 2 - 30,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color:
                          model.orderState == 4 ? Themes.add : Themes.discount,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    model.orderState == 4 ? "اضافة" : "خصم",
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
    );
  }

  ///////////////////////////api Wallet ///////////////////////////////////////////////

  Future<void> _fetchWalletBalance() async {
    try {
      final urlWallet = Uri.parse(api().url + api().WalletBalance);
      final response = await http.get(
        urlWallet,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final orders = jsonDecode(response.body);

      setState(() {
        _balance = orders['content'];
      });
    } catch (_) {}
  }

  Future<void> _fetchWalletTransactions() async {
    try {
      final dio = Dio()..options.headers = {"Authorization": "Bearer $token"};
      final service = WebServices(dio, baseUrl: api().url);
      final response = await service.getOrders();

      setState(() {
        _transactions = response.content
            .where((t) => t.orderState == 4 || t.orderState == 7)
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
