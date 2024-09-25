import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/data/enums/order_status.dart';
import 'package:pro_delivery/data/models/change_state_request_model.dart';
import 'package:pro_delivery/data/models/order_model.dart';
import 'package:pro_delivery/network/config_network.dart';
import 'package:pro_delivery/network/web_services.dart';

class OrderRepresentative extends StatefulWidget {
  final bool pending;
  OrderRepresentative({Key? key, this.pending = true}) : super(key: key);

  @override
  State<OrderRepresentative> createState() => _orderState();
}

class _orderState extends State<OrderRepresentative> {
  final _Storage = GetStorage();
  var _color = true;
  bool loading = false;

  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");

    // order();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading
                ? Visibility(
                    child: Container(
                    // margin: EdgeInsets.only(top: 25),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Themes.light.primaryColor),
                    )),
                  ))
                : _getOrders.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 100,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Text(
                              "لا يوجد طلبات",
                              style: GoogleFonts.cairo(fontSize: 20, color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _getOrders.length,
                          itemBuilder: (context, index) {
                            final order = _getOrders[index];
                            return _cardOrder(context, order);
                          },
                        ),
                      )
          ],
        ));
  }

  List<OrderModel> get _getOrders => widget.pending
      ? orders.where((e) => e.orderState == 1).toList()
      : orders.where((e) => e.orderState != 1).toList();

  _cardOrder(context, OrderModel order) {
    double _width = MediaQuery.of(context).size.width;

    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 12),
      width: double.infinity,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'رقم الطلب : ${order.orderNo}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _color == true ? Themes.dark_white : Themes.light_grey),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'الملاحظة',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _color == true ? Themes.dark_white : Themes.light_grey),
                    ),
                  ),
                  Container(
                    width: 160,
                    child: Text(
                      order.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(fontSize: 12, color: _color == true ? Themes.dark_white : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(children: [
                    Container(
                      width: _width / 4,
                      child: Text(
                        order.recipientPhoneNo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _color == true ? Themes.dark_white : Themes.light.primaryColor),
                      ),
                    ),
                  ]),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(
                      order.price.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _color == true ? Themes.dark_white : Themes.light.primaryColor),
                    ),
                    Text(
                      " د.ل ",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Themes.light_grey)),
                    ),
                  ]),
                  Container(
                    width: 100,
                    child: Text(
                      order.recipientAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(color: Themes.light_grey, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'الفرع',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(color: Themes.light_grey, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            // add three InkWell with text for each state
            // Delivered = 1,
            //  Returning,
            //  ReturnInTheWarehouse
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    changeState(order.orderNo, 1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: OrderState.Delivered.orderStatusColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      OrderState.Delivered.orderStatusName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: OrderState.Delivered.orderStatusColor,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    changeState(order.orderNo, 2);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: OrderState.Returning.orderStatusColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      OrderState.Returning.orderStatusName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: OrderState.Returning.orderStatusColor,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    changeState(order.orderNo, 3);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: OrderState.ReturnInTheWarehouse.orderStatusColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      OrderState.ReturnInTheWarehouse.orderStatusName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          textStyle: TextStyle(
                            color: OrderState.ReturnInTheWarehouse.orderStatusColor,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///////////////////////////api order ///////////////////////////////////////////////

  Future<void> order() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await WebServices(NetworkConfig.config()).getOrdersRepresentative();
      orders = response.content;

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> changeState(String orderNo, int orderState) async {
    try {
      var response = await WebServices(NetworkConfig.config())
          .changeOrderState(request: ChangeStateRequestRequest(orderNo: orderNo, orderState: orderState));

      order();
    } catch (e) {}
  }
}
