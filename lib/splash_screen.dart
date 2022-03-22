import 'dart:async';
import 'dart:ui';
import 'package:dr_drivers/api/AllRequest.dart';
import 'package:dr_drivers/pages/login/AllRide.dart';
import 'package:dr_drivers/pages/login/dashboard.dart';
import 'package:dr_drivers/pages/login/kyc_form.dart';
import 'package:dr_drivers/pages/login/login.dart';
import 'package:dr_drivers/preferences/app_shared_preferences.dart';
import 'package:dr_drivers/res/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   getPreferenceData();
  }

  void getPreferenceData() async {
    var token = await PreferenceHelper.getPreferenceData(PreferenceHelper.TOKEN);
    Timer(const Duration(seconds: 1), (){
      if(token != null && token != "") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  AllRide(initialIndex: 0,) )
        );
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Loginpage() )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background.JPG",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              color: Colors.black.withOpacity(0.48),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      width: 250,
                      height: 250,
                    ),
                    const Text(
                        "Drivers",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.yellow

                      ),

                    ),
                    const SizedBox(height: 12,),
                    const CircularProgressIndicator(
                      color: AppColor.BLUE_COLOR,
                      strokeWidth: 5,
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
