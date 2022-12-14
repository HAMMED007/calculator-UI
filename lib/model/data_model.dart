import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// class HistroicalData {
//   final String? title;
//   final String? subtitle;
//   final String? dateTime;

//   HistroicalData({
//     this.title,
//     this.subtitle,
//     this.dateTime,
//   });

//   //to map
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'subtitle': subtitle,
//       'dateTime': dateTime,
//     };
//   }

//   //from map
//   factory HistroicalData.fromMap(Map<String, dynamic> map) {
//     return HistroicalData(
//       title: map['title'],
//       subtitle: map['subtitle'],
//       dateTime: map['dateTime'],
//     );
//   }
// }

class GetDeviceId extends ChangeNotifier {
  String? deviceId;

  GetDeviceId() {
    getDeviceId();
  }
  getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    //
    if (GetPlatform.isAndroid) {
      await deviceInfo.androidInfo.then((value) {
        print(value.androidId);
        deviceId = value.androidId;
      });
    } else if (GetPlatform.isIOS) {
      await deviceInfo.iosInfo.then((value) {
        print(value.identifierForVendor);
        deviceId = value.identifierForVendor;
      });
    }
  }
}
