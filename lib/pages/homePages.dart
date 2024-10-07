import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/Notifications.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/AddOrder.dart';
import 'package:pro_delivery/pages/Branches.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/Details_Movements.dart';
import 'package:pro_delivery/pages/Order.dart';
import 'package:pro_delivery/pages/Setting.dart';
import 'package:pro_delivery/pages/SupplierRequest.dart';
import 'package:pro_delivery/pages/TabsOrder.dart';
import 'package:pro_delivery/pages/Wallet.dart';
import 'package:rxdart/rxdart.dart';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class homePagess extends StatefulWidget {
  homePagess({Key? key}) : super(key: key);

  @override
  State<homePagess> createState() => _homePagessState();
}

class _homePagessState extends State<homePagess> {
  int currentTab = 0;
  final List<Widget> Pages = [
    addOrder(),
    order(),
    wallet(),
    setting(),
    deliveryPrices(),
    // search(),
    branches(),
    tabsorder(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currenScreen = tabsorder();

  final _Storage = GetStorage();
  var _color = true;
  List branche = [];
  List dlyPrices = [];
  Map test = {"id": "2"};
  bool visible_ = false;
  var body = "";
  var token = "";
  var i = 0;
  String barcode = "";
  String status = "";
  List<Object>? code = [""];
  var userId = "";

  // var fbm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    noios();

    userId = _Storage.read("userId").toString();

    FirebaseMessaging.instance.subscribeToTopic(userId);

    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token");
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: _appBar(),
            body: PageStorage(
              child: currenScreen,
              bucket: bucket,
            ),
            floatingActionButton: currentTab == 4 || currentTab == 5
                ? null
                : FloatingActionButton(
                    backgroundColor: Themes.light.primaryColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await Navigator.pushNamed(context, 'addOrder');

                      // refresh page
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            bottomNavigationBar: BottomAppBar(
              // color: _color ? Themes.dark_primary2 : Themes.light_white ,
              color: Themes.light_white,
              shape: CircularNotchedRectangle(),
              notchMargin: 0,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _Storage.write("currenScreen", "0");
                          currenScreen = tabsorder();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0
                                ? Themes.light.primaryColor
                                : Themes.light_grey,
                          ),
                          Text(
                            "الطلبيات",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: _width < 321 ? 10 : 11,
                                  fontWeight: currentTab == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Themes.light_grey,
                                )),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,

                      onPressed: () {
                        setState(() {
                          currenScreen = wallet();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: currentTab == 1
                                ? Themes.light.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "المحفظة",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: _width < 321 ? 10 : 11,
                                  fontWeight: currentTab == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Themes.light_grey,
                                )),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,

                      onPressed: () {
                        setState(() {
                          currenScreen = deliveryPrices();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delivery_dining_sharp,
                            color: currentTab == 2
                                ? Themes.light.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "اسعار التوصيل",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: _width < 321 ? 10 : 11,
                                  fontWeight: currentTab == 2
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Themes.light_grey,
                                )),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(

                      onPressed: () {
                        setState(() {
                          currenScreen = setting();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? Themes.light.primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "الإعدادات",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontSize: _width < 321 ? 10 : 11,
                                  fontWeight: currentTab == 3
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Themes.light_grey,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  _appBar() {
    var appBarHeight = AppBar().preferredSize.height;

    return AppBar(
      backgroundColor: Themes.light.primaryColor,
      elevation: currentTab == 0 ? 0 : null,
      leading: Container(
          margin: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            // child: Image.asset(
            //   api().urlIcon,
            //   height: 40,
            //   width: 40,
            //   // fit: BoxFit.cover,
            // ),
          )),
      actions: <Widget>[
        // IconButton(
        //   icon: const Icon(
        //     Icons.search_outlined,
        //     size: 25,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       Navigator.pushNamed(context, 'search');
        //     });
        //   },
        // ),

        //    SizedBox(
        //   width: 20,
        // )

        PopupMenuButton(
          offset: Offset(0.0, appBarHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          onSelected: (result) {
            if (result == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addOrder()),
              );
            }
            if (result == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => supRequest()),
              );
            }
          },
          itemBuilder: (ctx) => [
            _buildPopupMenuItem('إضافة طلبية', Icons.add, 0),
            // _buildPopupMenuItem('طلب مندوب توصيل', Icons.delivery_dining, 1),
          ],
        )

        // Icon(
        //   Icons.notifications,
        //   size: 25,
        // ),
        // SizedBox(
        //   width: 20,
        // )
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData, value) {
    return PopupMenuItem(
      value: value,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Themes.dark_primary,
            ),
            SizedBox(
              width: 10,
            ),
            Text(title,
                style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Themes.light.primaryColor))),
          ],
        ),
      ),
    );
  }

  // invoke_() {
  //   if (hubConnection.state == HubConnectionState.Connected) {
  //     hubConnection.invoke("ReceiveNotification", args: code);
  //   }
  // }

  // void initSignalR() {
  //   try {
  //     print(token);
  //     HubConnection hubConnection;

  //     hubConnection = HubConnectionBuilder()
  //         .withUrl("https://www.demo.qdlibya.com/notificationsHub",
  //             options: HttpConnectionOptions(
  //                 accessTokenFactory: () async => await token))
  //         .build();

  //     hubConnection.on("ReceiveNotification", _mavements);

  //     hubConnection.start();
  //     // if (hubConnection.state == HubConnectionState.Connecting) {
  //     //   print("Connecting");
  //     // }
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  // void _mavements(List<Object>? args) {
  //   setState(() {
  //     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //         FlutterLocalNotificationsPlugin();
  //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //         AndroidNotificationDetails('your channel id', 'your channel name',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             showWhen: false);
  //     const NotificationDetails platformChannelSpecifics =
  //         NotificationDetails(android: androidPlatformChannelSpecifics);

  //     i++;

  //     flutterLocalNotificationsPlugin.show(
  //         i,
  //         "QdL",
  //         args![1].toString() + " رقم الشحنه " + args[0].toString(),
  //         platformChannelSpecifics,
  //         payload: 'item x');

  //   });
  // }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  Future<void> noios() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

class OrderStream {
  static final OrderStream instance = OrderStream._();

  OrderStream._();

  final StreamController<bool> controller = StreamController<bool>.broadcast();

  Stream<bool> get stream => controller.stream;
}
