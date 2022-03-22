import 'dart:async';
import 'dart:developer';

import 'package:dr_drivers/pages/login/AllRide.dart';
import 'package:dr_drivers/pages/login/map_utils.dart';
import 'package:dr_drivers/preferences/app_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workmanager/workmanager.dart';

import '../../SlideRightRoute.dart';
import '../../api/AllRequest.dart';
import '../../res/color.dart';
import '../../res/styles.dart';
import '../../res/text_size.dart';
import '../../widget/empty_app_bar.dart';
import 'side_menu.dart';
//import 'order confirmation page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.grey);
  double latitude = 0.0;
  double longitude = 0.0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;

  var spinkit = SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _showBottomSheet(context));

    Timer(const Duration(milliseconds: 100), saveRealTimeLocation);
  }

  void getCurrentLocation() async{
    await Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        latitude = currLocation.latitude;
        longitude = currLocation.longitude;
      });
    });
  }

  @override
  void dispose() {
    Workmanager().cancelAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
          backgroundColor: AppColor.backgroundColor,
        appBar: EmptyAppBar(),
      drawer: Drawer(
        child: NavDrawer(),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Image.asset(
                    'assets/images/ic_app_bar.JPG',
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  InkWell(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 64.0),
                      child: Icon(Icons.menu,size: 28,color: Colors.white,),

                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 50.0, bottom: 60.0),
                    child: const Text(
                      "DR. Drivers Cab",
                      style: Styles.toolbarTitle,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [



                  Container(
                    margin: EdgeInsets.only(top: 200),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllRide(
                                  initialIndex: 0,
                                )
                            )

                        );
                      },
                      child: const Text(
                        "Waiting for order ...",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24
                        )
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),

    );
  }
  Future _showDialog(context) {
    bool _value = false;
    int? selected = -1;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
            builder: (context, myState) {
              return  SingleChildScrollView(
                  child: Container(
//                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Container()),
                            const Expanded(
                              flex: 2,
                              child:  Text(
                                'Please Select',
                                style: TextStyle(
                                    fontSize: TextSize.headerText,
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.BLACK_COLOR
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => {Navigator.of(context).pop()},
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0,left: 16),
                                    child: Icon(Icons.close),

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16,),
                        GestureDetector(
                          onTap: (){
//                            Navigator.push(
//                                context,
//                                SlideRightRoute(
//                                    page: singleTrip()
//                                )
//                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  AppColor.BUTTON_COLOR,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 12),
                              margin: const EdgeInsets.only(top:10, left: 0),
                              alignment: Alignment.topCenter,
                              child: const Text(
                                "Single Trip",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: TextSize.headerText
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        GestureDetector(
                             onTap: () => {Navigator.of(context).pop()},
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  AppColor.BUTTON_COLOR,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 12),
                              alignment: Alignment.topCenter,
                              child: const Text(
                                "Round Trip",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: TextSize.headerText
                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  )
              );
            },
          ),

        );
      },
    );
  }

  _showBottomSheet(context){
    return showModalBottomSheet(
      isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, myState){
                return SingleChildScrollView(
                  child:  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16,top: 16,right: 16,bottom: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.white
                        ),
                        alignment: Alignment.bottomCenter,
//
//                    margin: EdgeInsets.only(top: 0,bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Hey! Vishal wants to ride with your',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Image.asset('assets/images/logo.png',),
                                      height: 70,
                                      width: 70,

                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10,top: 10),
                                      child: const Text(
                                        'DR Drivers',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "\u{20B9}202",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87
                                      ),
                                    ),
                                    Text(
                                      "16.8 Km",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.location_on,
                                  color: Colors.black,
                                ),
                                Text("Pickup Point",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.route_outlined,
                                  color: Colors.black,
                                ),
                                Text("H-126,Gyan Park,\nRam Nagar Extension",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),)
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [

                                Text("\      Krishna Nagar, Delhi\n     110051,India",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),),

                              ],
                            ),
                            Divider(thickness: 2,color: Colors.black,),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => {Navigator.of(context).pop()},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                            Colors.red,
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        margin: const EdgeInsets.only(top:0, left: 0,bottom: 5),
                                        alignment: Alignment.topCenter,
                                        child: const Text(
                                          "Reject",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: TextSize.headerText
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                 const SizedBox(width: 8,),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
//                                    MapUtils.openMap(28.535517, 77.391029);
                                        String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=28.535517,77.391029";
                                        if(await canLaunch(googleMapUrl)){
                                          await launch(googleMapUrl);
                                        } else{
                                          log('Could not open the map');
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                            Colors.green,
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        margin: const EdgeInsets.only(top:0, left: 0,bottom: 5),
                                        alignment: Alignment.topCenter,
                                        child: const Text(
                                          "Accept",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: TextSize.headerText
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                  ),
                );
              }
          );
        }
    );
  }
  void setVisibility() {
    if (mounted)
      setState(() {
        _isVisible = !_isVisible;
      });
  }
  Future<void> saveRealTimeLocation() async {
    var mobileNumber = await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "Email": "$mobileNumber",
      "Mode": "$latitude,$longitude",
    };
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


}
