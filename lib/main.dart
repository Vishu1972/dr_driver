
import 'dart:developer';

import 'package:dr_drivers/api/AllRequest.dart';
import 'package:dr_drivers/pages/login/dashboard.dart';
import 'package:dr_drivers/pages/login/notification_services.dart';
import 'package:dr_drivers/preferences/app_shared_preferences.dart';
import 'package:dr_drivers/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

SharedPreferences? pref;
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZJf40-wWQMeV_6IK1nwgwURSrGN8dRU0",
          appId: "1:210574108718:android:276a8c96dfc06b7de4d7bf",
          messagingSenderId: '210574108718',
          projectId: "dr-driver-ebe3d")
  );

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask(
    "2", "simplePeriodicTask",
    frequency: const Duration(milliseconds: 900000),
    initialDelay: const Duration(milliseconds: 0)
  );
//  SharedPreferences.setMockInitialValues({});
   pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $inputData"); //simpleTask will be emitted here.
    bool result = await saveRealTimeLocation();
    print("Result===$result");
    return Future.value(true);
  });
}

Future<bool> saveRealTimeLocation() async {
  var mobileNumber = pref?.getString(PreferenceHelper.MOBILE) ?? "";
  var online = pref?.getBool(PreferenceHelper.LOCATION_ON) ?? false;
  await Geolocator.getCurrentPosition().then((currLocation) async {
    print("Location=${currLocation.latitude}");
    try {
      if(online) {
        if (mobileNumber != "") {
          AllHttpRequest request = AllHttpRequest();
          var requestParameter = {
            "Email": mobileNumber,
            "Mode": "${currLocation.latitude},${currLocation.longitude}",
          };
          log("Request Parameters====$requestParameter");
          var response = await request.postRequest("RealTime", requestParameter);

          return Future.value(response != null);
        }
      }
    } catch(e) {
      log("ExceptionError====$e");
    }
  }).catchError((error) {
    log("Error====$error");
  });
  return Future.value(false);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DR CAB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


