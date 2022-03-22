
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/AllRequest.dart';
import '../../preferences/app_shared_preferences.dart';
import '../../res/color.dart';
import '../../res/text_size.dart';

class OngoingRide extends StatefulWidget {
  @override
  _OngoingRideState createState() => _OngoingRideState();
}

class _OngoingRideState extends State<OngoingRide> {

  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  List cabListOngoing = [];

  var spinkit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );
  @override
  void initState() {
    super.initState();
    getOngoingList();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cabListOngoing.isEmpty
                  ? Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 150),
                        alignment: Alignment.center,
                        child: const Text(
                            "No completed rides available yet!"
                        ),
                    ),
                  )
                  : ListView.builder(
                      itemCount: cabListOngoing.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Image.asset('assets/images/logo.png',),
                                    height: 70,
                                    width: 70,

                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10, top: 10),
                                      child:  Text(
                                        '${cabListOngoing[index]['CustomerNum']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children:  [

                                          Text(
                                            "${cabListOngoing[index]['Time']}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: const [
                                            Icon(Icons.location_on,
                                              color: Colors.white,
                                            ),
                                            Text("Pickup Point",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                           const Icon(Icons.route_outlined,
                                                color: Colors.white
                                            ),
                                            Text("${cabListOngoing[index]['sourceAddress']}",
                                              style:const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),)
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: const [

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(thickness: 5,color: Colors.white, width: 5,),

                                ],
                              ),

                              Divider(thickness: 2, color: Colors.white),
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
                                              Colors.deepOrange,
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          margin: const EdgeInsets.only(
                                              top: 0, left: 0, bottom: 5),
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            "Message",
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
                                          if (await canLaunch(googleMapUrl)) {
                                            await launch(googleMapUrl);
                                          } else {
                                            log('Could not open the map');
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.green,
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          margin: const EdgeInsets.only(
                                              top: 0, left: 0, bottom: 5),
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            "Open Map",
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
                                        onTap: () => {Navigator.of(context).pop()},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.green,
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          margin: const EdgeInsets.only(
                                              top: 0, left: 0, bottom: 5),
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            "Call",
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
                        );
                      }

                  ),
                  SizedBox(height: 48,)
                ],
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
        ),
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

  Future<void> getOngoingList() async {
    var mobileNumber =
    await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "ID": "1",
      "Number": "$mobileNumber",
    };
    print("Parameter====$requestParameter");
    var response = await request.postRequest("LocalCabHis", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Message'] == "Fail") {
        Fluttertoast.showToast(msg: "Show History");
      }else {
        setState(() {
          cabListOngoing = response['Result'] ?? [];
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
