import 'dart:async';
import 'dart:developer';

import 'package:dr_drivers/api/AllRequest.dart';
import 'package:dr_drivers/preferences/app_shared_preferences.dart';
import 'package:dr_drivers/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workmanager/workmanager.dart';

import '../../SlideRightRoute.dart';
import '../../res/text_size.dart';
import 'side_menu.dart';
import 'CompleteRide.dart';
import 'PendingRide.dart';
import 'dashboard.dart';
class AllRide extends StatefulWidget {
  final int initialIndex;
  const AllRide({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _AllRideState createState() => _AllRideState();
}

class _AllRideState extends State<AllRide> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int     initialIndex = 0;
  double latitude = 0.0;
  double longitude = 0.0;
  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  List bottomshit = [];
  List cabNotification = [];


  var spinKit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initialIndex = widget.initialIndex;
    });
//    Timer(const Duration(milliseconds: 100), saveRealTimeLocation);
  }

  void getCurrentLocation() async{
    await Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        latitude = currLocation.latitude;
        longitude = currLocation.longitude;
      });
    });
  }
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          initialIndex: initialIndex,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: AppColor.themeColor,
              title: InkWell(
                onTap: (){
                  Workmanager().cancelAll();
                },
                child: Text("Dashboard")
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.pending), text: "Pending Ride"),
                  Tab(icon: Icon(Icons.incomplete_circle_rounded), text: "Ongoing Ride")
                ],
              ),
            ),
            drawer: Drawer(
              child: NavDrawer(),
            ),
            body: TabBarView(
              children: [
                PendingRide(),
                OngoingRide()
              ],
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
                  spinKit,
                  SizedBox(height: 8,),
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
        )
      ],
    );
  }

  void setVisibility() {
    if (mounted) {
      setState(() {
        _isVisible = !_isVisible;
      });
    }
  }

  Future<void> saveRealTimeLocation() async {
    var mobileNumber = await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "Email": "$mobileNumber",
      "Mode": "$latitude,$longitude",
    };
    print("Request Parameters====$requestParameter");
    var response = await request.postRequest("RealTime", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Msg'] == "Fail") {
        Fluttertoast.showToast(msg: "Show History");
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }

  Future<void> approve() async {
    var mobileNumber = await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "ID": "$mobileNumber",
      "Empcode": "$mobileNumber",
      "Status": "$mobileNumber",
    };
    var response = await request.postRequest("PostApproveOrder", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Msg'] == "Fail") {
        Fluttertoast.showToast(msg: "Show History");
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
