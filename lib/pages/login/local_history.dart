
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../api/AllRequest.dart';
import '../../preferences/app_shared_preferences.dart';
import '../../res/color.dart';
import '../../res/styles.dart';
import '../../widget/empty_app_bar.dart';

class OngoingRides extends StatefulWidget {
  @override
  _OngoingRidesState createState() => _OngoingRidesState();
}

class _OngoingRidesState extends State<OngoingRides> {

  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  List cabList = [];

  var spinkit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );
  @override
  void initState() {
    super.initState();
    getLocalHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: EmptyAppBar(),
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
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin:const EdgeInsets.only(left: 10.0, bottom: 64.0),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50.0, bottom: 60.0),
                  child: const Text(
                    "Ride History",
                    style: Styles.toolbarTitle,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                cabList.isEmpty
                ? Center(
                   child: Container(
                     margin: const EdgeInsets.only(top: 150),
                     alignment: Alignment.center,
                     child: const Text(
                      "No history available yet!",
                     ),
                   ),
                )
                : ListView.builder(
                    itemCount: cabList.length,
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
//
//                    margin: EdgeInsets.only(top: 0,bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  child:  Text(
                                    '${cabList[index]['CustomerNum']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:  [
                                    Text(
                                      "\u{20B9}${cabList[index]['totalprice']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                    ),
                                    Text(
                                      "${cabList[index]['Time']}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                              ),
                              child: Row(
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
                                              color: Colors.black,
                                            ),
                                            Expanded(
                                              child: Text("Pickup Point",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                       const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Icon(Icons.route_outlined,
                                                color: Colors.white
                                            ),
                                            Expanded(
                                              child: Text("${cabList[index]['sourceAddress']}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                 const VerticalDivider(thickness: 5,color: Colors.white, width: 5,),
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
                                              color: Colors.black,
                                            ),
                                            Expanded(
                                              child: Text("Drop Point",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Icon(Icons.route_outlined,
                                                color: Colors.white
                                            ),
                                            Expanded(
                                              child: Text("${cabList[index]['destinationaddress']}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),),
                                            )
                                          ],
                                        ),

                                      ],
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
            ),
          ],
        ),
      ),
    );
  }


  void setVisibility() {
    if (mounted)
      setState(() {
        _isVisible = !_isVisible;
      });
  }

  Future<void> getLocalHistory() async {
    var mobileNumber =
    await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "ID": "0",
      "Number": "$mobileNumber",
    };
    var response = await request.postRequest("LocalCabHis", requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Msg'] == "Fail") {
        Fluttertoast.showToast(msg: "Show History");
      } else {
        setState(() {
          cabList = response['Result'];
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
