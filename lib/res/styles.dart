
import 'package:dr_drivers/res/text_size.dart';
import 'package:flutter/material.dart';

import 'color.dart';

abstract class Styles {
  static const toolbarTitle = TextStyle(
    color: Colors.white,
    fontSize: TextSize.textToolbarTitleSize,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static const textHeadingStyle = TextStyle(
    color: AppColor.FONT_COLOR,
    fontSize: TextSize.textHeadingSize,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static const textSubHeadingStyle = TextStyle(
      color: AppColor.FONT_COLOR,
      fontSize: TextSize.textSubHeadingSize,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      height: 1.3);

  static const textNormalStyle = TextStyle(
    color: AppColor.FONT_COLOR,
    fontSize: TextSize.textNormalSize,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const textBottomMenuStyle = TextStyle(
    color: Color(0xcf222222),
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const textBottomMenuRedStyle = TextStyle(
    color: Colors.redAccent,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const textFieldStyle = TextStyle(
    fontSize: TextSize.textFieldSize,
    color: AppColor.FONT_COLOR,
    fontWeight: FontWeight.normal,
  );

  static const submitButton = TextStyle(
    color: Colors.white,
    fontSize: TextSize.textButtonSize,
    fontWeight: FontWeight.normal,
  );

  static const textMenuStyle = TextStyle(
    color: AppColor.FONT_COLOR,
    fontSize: TextSize.textMenuSize,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static const noRecordFound = TextStyle(
    color: AppColor.FONT_COLOR,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );

  static const textCountryStyle = TextStyle(
      color: AppColor.WHITE_COLOR,
      fontSize: 18.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      height: 1.3
  );

  static const textWhiteStyle = TextStyle(
      color: AppColor.WHITE_COLOR,
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      height: 1.3
  );
}
