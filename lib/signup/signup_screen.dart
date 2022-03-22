
import 'package:dr_drivers/pages/login/AllRide.dart';
import 'package:dr_drivers/pages/login/cab_booking_screen.dart';
import 'package:dr_drivers/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../SlideRightRoute.dart';
import '../api/AllRequest.dart';
import '../pages/login/dashboard.dart';
import '../res/color.dart';
import '../res/text_size.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  AllHttpRequest request = AllHttpRequest();
  bool _isVisible = false;


  var spinkit = SpinKitWave(
    color:AppColor.themeColor,
    type: SpinKitWaveType.center,
    size: 50.0,
  );
  @override
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
                height: MediaQuery.of(context).size.height * 0.45,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/images/ic_background.png',
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
                    left: 16,
                    bottom: MediaQuery.of(context).size.height*0.12,
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        color: AppColor.WHITE_COLOR,
                        fontWeight: FontWeight.w700
                      ),
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

                  ],
                ),
              ),

              /// First Name
              Container(
                margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration:const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "First Name",
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

              /// Last Name
              Container(
                margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Last Name",
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

              /// Email
              Container(
                margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Email",
                          hintStyle:  TextStyle(
                              fontSize: TextSize.textNormalSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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

              /// password
              Container(
                margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Password",
                          hintStyle:  TextStyle(
                              fontSize: TextSize.textNormalSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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

              /// Confirm Password
              Container(
                margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: TextField(
                        controller: _confirmpasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Confirm Password",
                          hintStyle:  TextStyle(
                              fontSize: TextSize.textNormalSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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

              ///Mobile number
              Container(
                margin: const EdgeInsets.only(top: 16, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "+91",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppColor.themeColor,
                              fontSize: TextSize.textNormalSize
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: TextField(
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Mobile",
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



            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Loginpage()));
              },
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 32,right: 32,top: 16),
                child: const Text(
                  "Already Registered?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      fontSize: TextSize.subjectText
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

              InkWell(
                onTap: () {
                    if(_firstNameController.text == "") {
                      Fluttertoast.showToast(msg: "Please enter First name");
                    } else if(_lastNameController.text == "") {
                      Fluttertoast.showToast(msg: "Please enter Last name");
                    } else if(_emailController.text == "") {
                      Fluttertoast.showToast(msg: "Please enter Correct email");
                    } else if(_passwordController.text != _passwordController.text){
                      Fluttertoast.showToast(msg: "Please enter same ");
                    } else {
                      Registration();
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
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: TextSize.headerText
                      ),
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
        )
    );
  }

  void setVisibility() {
    if (mounted)
      setState(() {
        _isVisible = !_isVisible;
      });
  }

  Future<void> Registration() async {
    setVisibility();
    FocusScope.of(context).requestFocus(FocusNode());
    var requestParameter = {
      "FirstName": _firstNameController.text,
      "LastName": _lastNameController.text,
      "Number": _mobileNumberController.text,
      "Mail": _emailController.text,
      "Password": _passwordController.text,
      "ConfirmPassword": _confirmpasswordController.text,
    };

    var response = await request.postRequest("Registration", requestParameter);
    setVisibility();
    if(response != null){
      Fluttertoast.showToast(msg: "Registration successful");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong");
    }
    return null;
  }
}
