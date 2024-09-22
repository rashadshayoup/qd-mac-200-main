import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'package:pro_delivery/data/models/branch_model.dart';
import 'package:pro_delivery/data/models/city_model.dart';
import 'package:pro_delivery/network/config_network.dart';
import 'package:pro_delivery/network/web_services.dart';
import 'package:pro_delivery/widgets/picker/picker_field.dart';

class deliveryPrices extends StatefulWidget {
  deliveryPrices({Key? key, id}) : super(key: key);

  @override
  State<deliveryPrices> createState() => _deliveryPricesState();
}

class _deliveryPricesState extends State<deliveryPrices> {
  @override
  void initState() {
    super.initState();
    getBranches();
  }

  bool _color = false;
  final _Storage = GetStorage();

  String branchId = "";

  List<BranchModel> branches = [];
  List<CityModel> cities = [];

  @override
  Widget build(BuildContext context) {
    _color = _Storage.read("isDarkMode");
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: Column(
          children: [
            AppPicker(
                isExpanded: true,
                hintText: 'اختر الفرع',
                items: branches.map((e) => PickerModel(id: e.branchId, name: e.branchName)).toList(),
                onChanged: (value) {
                  setState(() {
                    branchId = value!;
                    getCities();
                  });
                }),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return _cardPrice(context, city);
                },
              ),
            ),
          ],
        ));
  }

  _cardPrice(context, CityModel city) {
    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");

    return Stack(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 100,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 12),
            decoration: BoxDecoration(
              color: _color == true ? Themes.dark_primary : Themes.light_white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _color == true ? Themes.dark_grey : Themes.light_white, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.black, size: 30),
                          SizedBox(width: 5),
                          Text(
                            city.name,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _color == true ? Themes.dark_white : Themes.light.primaryColor)),
                          ),
                        ],
                      ),
                      Row(children: [
                        Text(
                          city.price.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _color == true ? Themes.dark_white : Themes.light.primaryColor),
                        ),
                        Text(
                          " د.ل ",
                          style: GoogleFonts.cairo(
                              textStyle:
                                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Themes.light_grey)),
                        ),
                      ]),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  ///////////////////////////api deliveryPrices ///////////////////////////////////////////////

  Future<void> getBranches() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      var response = await webServices.branches();
      setState(() {
        branches = response.branches;
      });
    } catch (ex) {
      setState(() {});
    }
  }

  Future<void> getCities() async {
    try {
      final webServices = WebServices(NetworkConfig.config());
      var response = await webServices.citiesByBranch(branchId: branchId);
      setState(() {
        cities = response.content.first.cities ?? [];
      });
    } catch (ex) {
      setState(() {});
    }
  }
}
