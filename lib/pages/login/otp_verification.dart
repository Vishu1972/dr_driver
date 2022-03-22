import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../res/color.dart';
import '../../res/styles.dart';
import '../../signup/signup_screen.dart';
import '../../widget/custom_toast.dart';
import '../../widget/empty_app_bar.dart';

class VerifyOtpScreen extends StatefulWidget {
  final mobile;

  const VerifyOtpScreen({Key? key, this.mobile}) : super(key: key);
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  margin: EdgeInsets.only(left: 0.0, bottom: 64.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50.0, bottom: 60.0),
                  child: Text(
                    "Verify OTP",
                    style: Styles.toolbarTitle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),

            Container(
              child: Image.asset(
                'assets/images/otp_mobile.png',
                height: 140.0,
                width: 100.0,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                "OTP has been sent to your mobile\nnumber +91 ${widget.mobile}",
                style: const TextStyle(
                    height: 1.3,
                    color: AppColor.FONT_COLOR,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              child: const Center(
                child: Text(
                  "Enter OTP Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),


            Container(
              margin: const EdgeInsets.only(top: 30.0),
              child:  PinCodeTextField(
                pinBoxHeight: 40.0,
                pinBoxWidth: 60.0,
                autofocus: true,
                controller: _otpController,
                hideCharacter: false,
                highlight: true,
                highlightColor: AppColor.themeColor,
                defaultBorderColor: AppColor.GREY_COLOR,
                maxLength: 4,
                wrapAlignment: WrapAlignment.center,
                pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: AppColor.FONT_COLOR),
                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 200),
              ),
            ),
           const SizedBox(
              height: 12.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: const Text(
                      "Didn't receive the OTP?",
                      style: Styles.textFieldStyle,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _otpController.text = '';
                    },
                    child: Container(
                      child: const Text(
                        " Resend Code",
                        style: TextStyle(
                            color: AppColor.BUTTON_COLOR, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                if(_otpController.text.isEmpty){
                  CustomToast.showToastMessage("Please enter otp");
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen()
                    )
                  );
                }
              },
              child: Container(
                  child: const Center(
                    child: Text(
                      "Verify",
                      style: Styles.submitButton,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 40.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: AppColor.BUTTON_COLOR,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ])),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
