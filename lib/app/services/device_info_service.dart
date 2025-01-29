// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
//
// class DeviceInfoService {
//   /// Method to get the device ID
//   static Future<String?> getDeviceId() async {
//     try {
//       final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//       if (defaultTargetPlatform == TargetPlatform.android) {
//         AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//         return androidInfo.id; // Get the Android ID
//       } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//         return iosInfo.identifierForVendor; // Get the iOS device ID
//       }
//
//       return null; // Unsupported platform
//     } catch (e) {
//       debugPrint('Error fetching device ID: $e');
//       return null;
//     }
//   }
// }
