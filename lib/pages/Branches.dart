import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/Maps.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class branches extends StatefulWidget {
  branches({Key? key}) : super(key: key);

  @override
  State<branches> createState() => _branchesState();
}

class _branchesState extends State<branches> {
  final _Storage = GetStorage();
  var _color = false;
  List branche = [];
  bool visible_lodding = false;
  bool visible_lodding_net = false;
  bool visible_body = false;
  String token = "";
  bool net = false;

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token");

    Branches();
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
                      visible: visible_lodding_net,
                      child: Container(
                        // margin: EdgeInsets.only(top: 25),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  // Visibility(
                  //   visible: !visible_lodding_net,
                  //   child: Center(
                  //     child: Image.asset(
                  //       'assets/net.png',
                  //       width: 200,
                  //     ),
                  //   ),
                  // ),
                  Visibility(
                    visible: !visible_lodding_net,
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
                    visible: !visible_lodding_net,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            Branches();
                            visible_lodding_net = true;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Visibility(
                  //   visible: visible_body,
                  //   child: _cardTite(context),
                  // ),

                  Visibility(
                      visible: visible_lodding,
                      child: Container(
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  SizedBox(height: 20),
                  Visibility(
                      visible: visible_body,
                      child: Expanded(
                        child: RefreshIndicator(
                          color: Themes.light.primaryColor,
                          onRefresh: Branches,
                          child: ListView.builder(
                              itemCount: branche.length,
                              itemBuilder: (context, i) {
                                return _cardBranch(context, i);
                              }),
                        ),
                      )),
                  SizedBox(
                    height: 13,
                  ),
                ],
              ));
  }

  _cardTite(context) {
    double _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 100,
          margin: EdgeInsets.fromLTRB(20, 25, 20, 20),
          width: _width - 40,
          decoration: BoxDecoration(
            color: Themes.light.primaryColor,
            borderRadius: BorderRadius.circular(20),
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
                      width: _width - 82,
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "لمعرفة اسعار التوصيل قم بختيار الفرع الذي تريده ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Themes.light_white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _cardBranch(context, index) {
    double _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 135,
          margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
          width: _width - 40,
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
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: _width / 2,
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        branche[index]["name"].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _color == true
                                    ? Themes.dark_white
                                    : Themes.light.primaryColor)),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          branche[index]["phone1"].toString()  == 'null' ? '':  branche[index]["phone1"].toString(),
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor)),
                        ),
                        Text(
                          branche[index]["phone2"].toString() == 'null' ? '':  branche[index]["phone2"].toString(),
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor)),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'deliveryPrices',
                            arguments: branche[index]['id']);
                      },
                      child: Container(
                        width: _width / 2 - 30,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Themes.light.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "اسعار التوصيل",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                            color: Themes.light_white,
                          )),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        // MapUrl.openMap(47.628293269721, -122.34263420105);
                        MapUrl.openMap(branche[index]["location"].toString());
                      },
                      child: Container(
                        width: _width / 2 - 30,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Themes.light.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "الموقع",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                            color: Themes.light_white,
                          )),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  ///////////////////////////api Branches ///////////////////////////////////////////////

  Future<void> Branches() async {
    try {
      visible_lodding = true;
      visible_lodding_net = true;
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
        visible_lodding = false;
        visible_lodding_net = false;
        visible_body = true;
        net = false;
      }
    } on SocketException {
      setState(() {
        visible_lodding = false;
        visible_lodding_net = false;

        net = true;
      });
    } catch (ex) {
      visible_lodding = false;
      visible_lodding_net = false;
    }
  }
}
