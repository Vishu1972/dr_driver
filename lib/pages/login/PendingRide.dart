import 'dart:developer';

import 'package:dr_drivers/pages/login/AllRide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../SlideRightRoute.dart';
import '../../api/AllRequest.dart';
import '../../preferences/app_shared_preferences.dart';
import '../../res/color.dart';
import '../../res/text_size.dart';
import 'CompleteRide.dart';
import 'local_history.dart';
class PendingRide extends StatefulWidget {
  @override
  _PendingRideState createState() => _PendingRideState();
}

class _PendingRideState extends State<PendingRide> {

  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  List cabListPending = [];

  var spinkit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _showBottomSheet(context));

    getPendingList();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: cabListPending.isEmpty
          ? Center(
            child: Container(
                margin: const EdgeInsets.only(top: 150),
                alignment: Alignment.center,
                child: const Text(
                    "No pending rides available yet!",
                ),
            ),
          )
          : ListView.builder(
              itemCount: cabListPending.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                          SizedBox(
                            child: Image.asset('assets/images/logo.png',),
                            height: 70,
                            width: 70,

                          ),
                          Expanded(
                            child: Container(

                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child:  Text(
                                '${cabListPending[index]['CustomerNum']}',
                                style:const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                            child: Text(
                              "${cabListPending[index]['Time']}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
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
                     const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          const Icon(Icons.route_outlined,
                              color: Colors.white
                          ),
                          Text(
                            "${cabListPending[index]['sourceAddress']}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),)
                        ],
                      ),
                      SizedBox(height: 5),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: const [
//
//                          Text("\      Krishna Nagar, Delhi\n     110051,India",
//                            style: TextStyle(
//                                fontSize: 16,
//                                fontWeight: FontWeight.w500,
//                                color: Colors.white
//                            ),),
//
//                        ],
//                      ),
                      Divider(thickness: 2, color: Colors.white),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  postApproveOrder(cabListPending[index]['Id'], 'r', index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                      Colors.red,
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  margin: const EdgeInsets.only(
                                      top: 0, left: 0, bottom: 5),
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
                            SizedBox(width: 8,),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  postApproveOrder(cabListPending[index]['Id'], 'a', index);
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


                );
              }

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
        )
      ],
    );
  }

  void setVisibility() {
    if (mounted)
      setState(() {
        _isVisible = !_isVisible;
      });
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
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 0, left: 16, right: 16),
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white
                        ),
                        alignment: Alignment.bottomCenter,
//
//                            margin: EdgeInsets.only(top: 0,bottom: 0),
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
                                      margin: const EdgeInsets.only(left: 10, top: 10),
                                      child: const Text(
                                        'Vishal 7009873016 ',
                                        style:TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const Text(
                                  "02:07 PM",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                )
                              ],
                            ),
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
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.route_outlined,
                                    color: Colors.black
                                ),
                                Text(
                                  "Noida Greater, Noida Expressway, Block - C, Ansal Golf Link 1, Greater Noida, Uttar Pradesh, India",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),)
                              ],
                            ),
                            SizedBox(height: 5),

                            Divider(thickness: 2, color: Colors.black),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        margin: const EdgeInsets.only(
                                            top: 0, left: 0, bottom: 5),
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
                                  SizedBox(width: 8,),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => {
                                        Navigator.push(context, SlideRightRoute(page: const AllRide(
                                          initialIndex: 1,
                                        )))
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
                            SizedBox(height: 0,)
                          ],
                        ),


                      ),
                    ),
                  ],
                );
              }
          );
        }
    );
  }

  Future<void> getPendingList() async {
    var mobileNumber =
    await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "ID": "1",
      "Number": "$mobileNumber",
    };
    var response = await request.postRequest("LocalCabHis", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Message'] == "Fail") {
        Fluttertoast.showToast(msg: "${response['Message']}");
      } else {
        setState(() {
          cabListPending = response['Result'] ?? [];
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }

  Future<void> postApproveOrder(id, status, index) async {
    var mobileNumber = await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "ID": "$id",
      "Empcode": "$mobileNumber",
      "Status": "$status",
    };
    print(requestParameter);
    var response = await request.postRequest("PostApproveOrder", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Msg'] == "Save") {
        setState(() {
          cabListPending.removeAt(index);
        });
        if(status == "a"){
          Navigator.push(context, SlideRightRoute(page: const AllRide(
            initialIndex: 1,
          )));
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    return null;
  }
}
