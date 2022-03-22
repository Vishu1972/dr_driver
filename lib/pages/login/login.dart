
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geofencing/geofencing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import '../../SlideRightRoute.dart';
import '../../api/AllRequest.dart';
import '../../preferences/app_shared_preferences.dart';
import '../../res/color.dart';
import '../../res/text_size.dart';
import '../../signup/signup_screen.dart';
import 'AllRide.dart';
import 'dashboard.dart';
import 'otp_verification.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  String deviceId = "";
  final FirebaseMessaging _fireBaseMessaging = FirebaseMessaging.instance;

  var spinkit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );


  /***
   * GeoFencing start
   */
  String geofenceState = 'N/A';
  List<String> registeredGeofences = [];
  double latitude = 37.419851;
  double longitude = -122.078818;
  double radius = 150.0;
  ReceivePort port = ReceivePort();
  final List<GeofenceEvent> triggers = <GeofenceEvent>[
    GeofenceEvent.enter,
    GeofenceEvent.dwell,
    GeofenceEvent.exit
  ];
  final AndroidGeofencingSettings androidSettings = AndroidGeofencingSettings(
      initialTrigger: <GeofenceEvent>[
        GeofenceEvent.enter,
        GeofenceEvent.exit,
        GeofenceEvent.dwell
      ],
      loiteringDelay: 1000 * 60);

  @override
  void initState() {
    super.initState();
    print("hello");
    _fireBaseMessaging.getToken().then((token) {
      print('FCM Token : $token');
      deviceId = token.toString();

      debugPrint('FCM Token : $deviceId');
    });
    print("hello111");

    IsolateNameServer.registerPortWithName(
        port.sendPort, 'geofencing_send_port');
    port.listen((dynamic data) {
      print('Event: $data');
      setState(() {
        geofenceState = data;
      });
    });
    initPlatformState();
  }

  static void callback(List<String> ids, Location l, GeofenceEvent e) async {
    print('Fences: $ids Location $l Event: $e');
    final SendPort? send = IsolateNameServer.lookupPortByName('geofencing_send_port');
    send?.send(e.toString());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    print('Initializing...');
    await GeofencingManager.initialize();
    print('Initialization done');
  }

  @override
  void dispose() {
    Workmanager().cancelAll();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.50,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/ic_background.png',
                  ),
                  Positioned(
                    left: 28,
                    bottom: MediaQuery.of(context).size.height*0.15,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 26,
                          color: AppColor.WHITE_COLOR,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: Image.asset(
                      'assets/login/ic_light2.png'
                    ),
                  ),

                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Image.asset(
                      'assets/login/ic_light2.png'
                    )
                  ),

                  Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Image.asset(
                          'assets/login/ic_clock.png'
                      )
                  ),

                  Positioned(
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height * 0.35,
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            print("Code changes");
                            Workmanager().cancelAll().then((value) {
                              log("Cancelled");
                            });

                            if (latitude == null) {
                              setState(() => latitude = 0.0);
                            }
                            if (longitude == null) {
                              setState(() => longitude = 0.0);
                            }
                            if (radius == null) {
                              setState(() => radius = 0.0);
                            }

                            GeofencingManager.registerGeofence(
                                GeofenceRegion(
                                    'mtv', latitude, longitude, radius, triggers,
                                    androidSettings: androidSettings),
                                callback).then((_) {
                              GeofencingManager.getRegisteredGeofenceIds().then((value) {
                                setState(() {
                                  registeredGeofences = value;
                                });
                              });
                            });
                          },
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 150,
                            height: 180,
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
              Container(
                margin: const EdgeInsets.only(top: 25, left: 32, right: 32),

                alignment: Alignment.centerLeft,
                child: const Text(
                  'Enter Email',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.black38
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 0, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
//                      const Text(
//                        "+91",
//                        style: TextStyle(
//                            fontWeight: FontWeight.w900,
//                            color: AppColor.themeColor,
//                            fontSize: TextSize.textNormalSize
//                        ),
//                      ),
                        Expanded(
                          child: Container(
                            margin:  const EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: _emailController,

                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    fontSize: TextSize.textNormalSize,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: TextSize.textNormalSize
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColor.themeColor,
                      height: 2,
                      thickness: 2,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, left: 28, right: 32),
//              alignment: Alignment.centerLeft,
                child: const Text(
                  'Enter Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.black38
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 0, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin:  const EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontSize: TextSize.textNormalSize,
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: TextSize.textNormalSize
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.themeColor,
                      height: 2,
                      thickness: 2,
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 32,right: 32,top: 16),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      fontSize: TextSize.subjectText
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              InkWell(
                onTap: () {
                  if (_emailController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Please enter Correct Email");
                  } else if (_passwordController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Please enter Correct Password");
                  } else {
                    Login();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color:
                        AppColor.BUTTON_COLOR,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    margin: const EdgeInsets.only(top:48, left: 0),
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: TextSize.headerText
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupScreen()));
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin:
                  const EdgeInsets.only(left: 32, right: 32, top: 16),
                  child: const Text(
                    "New to Dr Cab?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: TextSize.headerText),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.WHITE_COLOR
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        spinkit,
                        const SizedBox(height: 8,),
                        const Text(
                          'Please Wait',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.BLACK_COLOR,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),


          ],
        ),
      )
    );
  }
//  Future<void> loginUser() async {
//    FocusScope.of(context).requestFocus(FocusNode());
//    var requestParameter = {
//      "Email": _emailController.text,
//      "password": _passwordController.text
//    };
//
//    var response = await request.login("api/login", requestParameter);
//    if(response != null){
//      debugPrint("First Name === ${response["info"]["first_name"]}");
//      debugPrint("Message === ${response["message"]}");
//      debugPrint("Message === ${response["info"]['mobile_number']}");
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//
//      prefs.setString("Token", response['info']['auth_token']);
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => SignupScreen()),
//      );
//    } else {
//    }
//    return null;
//  }
  void setVisibility() {
    if (mounted) {
      setState(() {
        _isVisible = !_isVisible;
      });
    }
  }

  Future<void> Login() async {
    setVisibility();
    FocusScope.of(context).requestFocus(FocusNode());
    var requestParameter = {
      "Email": _emailController.text,
      "Password": _passwordController.text,
      "Mode": "",
      "Token": "$deviceId",
    };
//Phone,Password,Mode,Token
    print("RequestParameter====$requestParameter");
    var response = await request.postRequest("LoginRequest", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Message'] == "An error has occurred.") {
//        Navigator.push(context, SlideRightRoute(page: DashboardScreen()));

        Fluttertoast.showToast(msg: "Login Unsuccessful");
      } else {
        PreferenceHelper.setPreferenceData(PreferenceHelper.TOKEN, deviceId);
        PreferenceHelper.setPreferenceData(PreferenceHelper.MOBILE, _emailController.text);
        Navigator.push(context, SlideRightRoute(page: const AllRide(initialIndex: 0,)));
        Fluttertoast.showToast(msg: "Login successful");

        PreferenceHelper.clearPreferenceData(PreferenceHelper.LOCATION_ON);
        PreferenceHelper.setPreferenceBoolData(PreferenceHelper.LOCATION_ON, true);
      }
//      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
