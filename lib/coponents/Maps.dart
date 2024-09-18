import 'dart:async';

import 'package:url_launcher/url_launcher_string.dart';

class MapUrl {
MapUrl._();
static Future <void> openMap(
  String latitude_longitude ,
 ) async {
  
  //  String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude+$longitude"; // فتح بستخدام الموقع
     String googleMapUrl = "google.navigation:q=$latitude_longitude&mode=d"; // فتح بستخدام التطبيق

   if(await canLaunchUrlString(googleMapUrl)){
     await launchUrlString(googleMapUrl);
   }

   else {
String urlGoogleMaps =
        "https://www.google.com/maps/search/?api=1&query=$latitude_longitude";
             await launchUrlString(urlGoogleMaps);


   }
 }
}