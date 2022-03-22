import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/AllRequest.dart';
import '../../preferences/app_shared_preferences.dart';
import '../../res/color.dart';
import '../../res/styles.dart';
import '../../res/text_size.dart';
import '../../widget/empty_app_bar.dart';
import 'dashboard.dart';

class KycVerification extends StatefulWidget {
  @override
  _KycVerificationState createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {

  ImagePicker _imagePicker = ImagePicker();
  String aadharPath1 = "";
  String profilePath1 = "";
  String profilePath2 = "";
  String aadharPath2 = "";
  String driverImagePath1 = "";
  String driverImagePath2 = "";
  String driverRcImagePath = "";
  String driverLicImagePath1 = "";
  String driverNationalPermitImagePath1 = "";
  String driverStatePermitImagePath1 = "";
  bool isPhotoTaken = false;
  bool rememberMe = false;



  Future getImageFromCamera(type) async {
    var image1 = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image1 != null) {
      setState(() {
        switch(type) {

          case "profile1":
            profilePath1 = image1.path;
            break;

            case "profile2":
            profilePath2 = image1.path;
            break;

          case "aadhar1":
            aadharPath1 = image1.path;
            break;


          case "aadhar2":
            aadharPath2 = image1.path;
            break;

          case "driverAadhar1":
            driverImagePath1 = image1.path;
            break;

          case "driverAadhar2":
            driverImagePath2 = image1.path;
            break;

          case "driverRc":
            driverRcImagePath = image1.path;
            break;

            case "driverLic":
              driverLicImagePath1 = image1.path;
            break;

            case "driverState":
            driverNationalPermitImagePath1 = image1.path;
            break;


          case "driverNational":
            driverStatePermitImagePath1 = image1.path;
            break;


        }
      });
    }
  }

  Future getImageFromGallery(type) async {
    var image1 = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image1 != null) {
      setState(() {
        switch(type) {
          case "aadhar1":
            aadharPath1 = image1.path;
            break;

          case "aadhar2":
            aadharPath2 = image1.path;
            break;

          case "driverAadhar1":
            driverImagePath1 = image1.path;
            break;

          case "driverAadhar2":
            driverImagePath2 = image1.path;
            break;

          case "driverRc":
            driverRcImagePath = image1.path;
            break;

          case "driverLic":
            driverLicImagePath1 = image1.path;
            break;


          case "driverNational":
            driverNationalPermitImagePath1 = image1.path;
            break;


          case "driverState":
            driverStatePermitImagePath1 = image1.path;
            break;


          case "profile1":
            profilePath1 = image1.path;
            break;

          case "profile2":
            profilePath2 = image1.path;
            break;

          default:
            break;
        }
      });
    }
  }
  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;
  List kycDetail = [];
  final _ownernameController = TextEditingController();
  final _drivernameController = TextEditingController();
  final _owneradharController = TextEditingController();
  final _driveradharController = TextEditingController();
  final _vehiclenumberController = TextEditingController();
  final _permitController = TextEditingController();
  final _licenceController = TextEditingController();


  var spinkit = const SpinKitFadingCircle(
    color: AppColor.PRIMARY_STAGE_COLOR,
    size: 35.0,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: EmptyAppBar(),
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SingleChildScrollView(
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
//                        Navigator.pop(context);
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
                        margin: const EdgeInsets.only(left: 50.0, bottom: 60.0),
                        child: const Text(
                          "Kyc Verification",
                          style: Styles.toolbarTitle,
                        ),
                      ),
                    ],
                  ),
                  ///Owner detail
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.GREY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
//                border: Border.all(color: AppColor.themeColor,width: 0,)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Owner Detail ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            InkWell(
                              onTap: (){
                                bottomNavigation(context,"profile1");
                              },
                               child: profilePath1 == ""
                              ?Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(64),
                                  child:
                                  Image.asset(
                                    'assets/images/profile.jpg',
                                    width: 60,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                                   : ClipRRect(
                                 borderRadius: BorderRadius.circular(20),
                                 child: Image.file(
                                   File(profilePath1),
                                   width: 80,
                                   height: 80.0,
                                   fit: BoxFit.cover,
                                 ),
                               ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 0, left: 16, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child:  TextField(
                                        controller: _ownernameController,
                                        decoration:const InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          fillColor: Colors.white,
                                          filled: false,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          hintText: "Owner Name",
                                          hintStyle:  TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black38,


                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: TextSize.textNormalSize
                                        ),
                                      ),
                                    ),
//                        Divider(
//                          color: AppColor.themeColor,
//                          height: 2,
//                          thickness: 2,
//                        ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 0),
                                      child:  TextField(
                                        controller: _owneradharController,
                                        keyboardType: TextInputType.number,
                                        decoration:const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: false,
                                          hintText: "Adhar No.",
                                          hintStyle:  TextStyle(
                                              fontSize: 14,
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
                            ),
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 16,),

                          child: const Text(
                            "Upload your Adhar card ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context,"aadhar1");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child: aadharPath1 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Expanded(
                                          child: Text(
                                            "Upload Image",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(aadharPath1),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context, "aadhar2");
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child:  aadharPath2 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Text(
                                          "Upload Image",
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(aadharPath2),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///Driver detail

                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.GREY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
//                border: Border.all(color: AppColor.themeColor,width: 0,)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Driver Detail ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            InkWell(
                            onTap: (){
                             bottomNavigation(context,"profile2");
                                    },
                               child: profilePath2 == ""

                                  ?ClipRRect(
                                  borderRadius: BorderRadius.circular(64),
                                  child:
                                  Image.asset(
                                    'assets/images/profile.jpg',
                                    width: 60,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                              )
                                   : ClipRRect(
                                 borderRadius: BorderRadius.circular(20),
                                 child: Image.file(
                                   File(profilePath2),
                                   width: 80,
                                   height: 80.0,
                                   fit: BoxFit.cover,
                                 ),
                               ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 0, left: 16, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextField(
                                        controller: _drivernameController,
                                        decoration:const InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          fillColor: Colors.white,
                                          filled: false,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColor.themeColor,
                                                width: 2,
                                              )
                                          ),
                                          hintText: "Driver Name",
                                          hintStyle:  TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black38,


                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: TextSize.textNormalSize
                                        ),
                                      ),
                                    ),
//                        Divider(
//                          color: AppColor.themeColor,
//                          height: 2,
//                          thickness: 2,
//                        ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 0),
                                      child:  TextField(
                                        controller: _driveradharController,
                                        keyboardType: TextInputType.number,
                                        decoration:const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: false,
                                          hintText: "Adhar No.",
                                          hintStyle:  TextStyle(
                                              fontSize: 14,
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
                            ),
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 16,),

                          child: const Text(
                            "Upload your Adhar card ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context,"driverAadhar1");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child: driverImagePath1 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Expanded(
                                          child: Text(
                                            "Upload Image",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverImagePath1),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context, "driverAadhar2");
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child:  driverImagePath2 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Text(
                                          "Upload Image",
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverImagePath2),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///Car Detail

                  Container(
                    margin: const EdgeInsets.all(16),

                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.GREY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
//                border: Border.all(color: AppColor.themeColor,width: 0,)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Car Detail ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),

                        Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 6),
                                child:  TextField(
                                  controller: _vehiclenumberController,
                                  decoration:const InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: false,
                                    hintText: "Vechle Number",
                                    hintStyle:  TextStyle(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: TextField(
                                controller: _permitController,
                                keyboardType: TextInputType.number,
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: false,
                                  hintText: "Permit",
                                  hintStyle:  TextStyle(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: TextField(
                                controller: _licenceController,
                                keyboardType: TextInputType.number,
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: false,
                                  hintText: "Licence no.",
                                  hintStyle:  TextStyle(
                                      fontSize: TextSize.textNormalSize,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38
                                  ),
                                ),
                                style: TextStyle(
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(

                                padding: const EdgeInsets.only(top: 10,left: 6),
                                child: const Text(
                                  "Upload Rc",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(

                                padding: const EdgeInsets.only(top: 10,left: 6),
                                child: const Text(
                                  "Upload Licence",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context,"driverRc");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child: driverRcImagePath == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Expanded(
                                          child: Text(
                                            "Upload Image",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverRcImagePath),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context, "driverLic");
                                },
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child:  driverLicImagePath1 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(25),
                                    child: Column(
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Text(
                                          "Upload Image",
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverLicImagePath1),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(

                                padding: const EdgeInsets.only(top: 0,left: 10),
                                child: const Text(
                                  "National Permit ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(

                                padding: const EdgeInsets.only(top: 0,left: 10),
                                child: const Text(
                                  "State Permit ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context,"driverNational");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child: driverNationalPermitImagePath1 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Expanded(
                                          child: Text(
                                            "Upload Image",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverNationalPermitImagePath1),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  bottomNavigation(context, "driverNational");
                                },
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 120,

                                  child:  driverStatePermitImagePath1 == ""
                                      ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        Text(
                                          "Upload Image",
                                        ),
                                      ],
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(driverStatePermitImagePath1),
                                      width: 80,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
//                    Checkbox(
//                        value: checkBoxValue,
//                        activeColor: Colors.green,
//                        onChanged:(bool newValue){
//                          setState(() {
//                            checkBoxValue = newValue;
//                          });
//                          Text('Remember me');
//                        }),
                    ],
                  ),
                ),

                  InkWell(
                    onTap: () {
                      if (_ownernameController.text == "") {

                      } else if (_owneradharController == "") {

                      } else if (_drivernameController == "") {

                      } else if (_driveradharController == "") {

                      } else if (_vehiclenumberController == "") {

                      } else if (_permitController == "") {

                      } else if (_licenceController == "") {

                      } else {
                        uploadKycForm();
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
                        margin: const EdgeInsets.only(top:15, left: 0,bottom: 15),
                        alignment: Alignment.topCenter,
                        child: const Text(
                          "Submit",
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

  void bottomNavigation(context, type){
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        backgroundColor: Colors.white,
        isDismissible: false,
        builder: (context){
          return StatefulBuilder(
            builder: (context1, myState){
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          getImageFromCamera(type);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                          child: const Text(
                            'Take Photo',
                            style: TextStyle(
                                fontSize: TextSize.headerText,
                                color: AppColor.BLACK_COLOR,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'WorkSans'
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: AppColor.GREY_COLOR,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          getImageFromGallery(type);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                          child: const Text(
                            'Choose from library',
                            style: TextStyle(
                                fontSize: TextSize.headerText,
                                color: AppColor.BLACK_COLOR,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'WorkSans'
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColor.GREY_COLOR,
                        thickness: 1.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: TextSize.headerText,
                                color: AppColor.BLACK_COLOR.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'WorkSans'
                            ),
                          ),
                        ),
                      ),

                     const SizedBox(
                        height: 12.0,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  void setVisibility() {
    if (mounted) {
      setState(() {
        _isVisible = !_isVisible;
      });
    }
  }

  Future<void> uploadKycForm() async {
    var mobileNumber =
    await PreferenceHelper.getPreferenceData(PreferenceHelper.MOBILE);
    setVisibility();
    var requestParameter = {
      "Name": _ownernameController.text.toString().trim(),
      "AadharNumber": _owneradharController.text.toString().trim(),
      "DriverMobile": "",
      "DriverAadharNumber": _driveradharController.text.toString().trim(),
      "Vehiclenumber": _vehiclenumberController.text.toString().trim(),
      "Insurancestart": "",
      "Insuranceend ": "",
      "Permit": _vehiclenumberController.text.toString().trim(),
      "confirmation": "",
    };

    List<Map<String, dynamic>> imageList = [];
    if(aadharPath1 != "") {
      imageList.add({"path": aadharPath1, "key": "AadharImage"});
    }
    if(aadharPath2 != "") {
      imageList.add({"path": aadharPath2, "key": "AadharImage2"});
    }
    if(profilePath1 != "") {
      imageList.add({"path": profilePath1, "key": "Photo"});
    }
    if(profilePath2 != "") {
      imageList.add({"path": profilePath2, "key": "DriverPhoto"});
    }
    if(driverImagePath1 != "") {
      imageList.add({"path": driverImagePath1, "key": "DriverAadharImage"});
    }
    if(driverImagePath2 != "") {
      imageList.add({"path": driverImagePath2, "key": "DriverAadharImage2"});
    }
    if(driverRcImagePath != "") {
      imageList.add({"path": driverRcImagePath, "key": "CarRcPhoto"});
    }
    var response = await request.uploadResource(
        "Ownerdetail", imageList, requestParameter);
    setVisibility();
    if (response != null) {
      if (response['Msg'] == "Fail") {
        Fluttertoast.showToast(msg: "Something Wrong");
      } else {
        setState(() {
          kycDetail = response['Result'];
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
