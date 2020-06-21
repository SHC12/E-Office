import 'package:e_office/util/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double defaultScreenWidth = 750;
double defaultScreenHeight = 1334;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class Sizes {
  static double s0 = 0;
  static double s1 = 1;
  static double s2 = 2;
  static double s3 = 3;
  static double s4 = 4;
  static double s5 = 5;
  static double s6 = 6;
  static double s8 = 8;
  static double s10 = 10;
  static double s12 = 12;
  static double s14 = 14;
  static double s15 = 15;
  static double s16 = 16;
  static double s18 = 18;
  static double s20 = 20;
  static double s25 = 25;
  static double s30 = 30;
  static double s40 = 40;
  static double s50 = 50;
  static double s60 = 60;
  static double s70 = 70;
  static double s80 = 80;
  static double s100 = 100;
  static double s120 = 120;
  static double s150 = 150;
  static double s165 = 165;
  static double s200 = 200;
  static double s300 = 300;

  /*Image Dimensions*/

  static double defaultIconSize = 25;
  static double defaultImageHeight = 100;
  static double defaultCardHeight = 120;
  static double defaultImageRadius = 40;
  static double snackBarHeight = 50;
  static double texIconSize = 30;
  static double circularImageRadius = 36;

  /*Default Height&Width*/
  static double defaultIndicatorHeight = 5;
  static double alertHeight = 200;
  static double appBarHeight = 235;
  static double minWidthAlertButton = 70;

  /*EdgeInsets*/
  static EdgeInsets spacingAllDefault = EdgeInsets.all(s8);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(s10);
  static EdgeInsets spacingAllExtraSmall = EdgeInsets.all(s10);
  static EdgeInsets spacingClock = EdgeInsets.symmetric(horizontal: s80);

  static Future setScreenAwareConstant(context) async {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    getSize() async {
      if (screenWidth == 0 || screenHeight == 0) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
        await Future.delayed(Duration(milliseconds: 300));
        await getSize();
      }
    }

    await getSize();

    appLogs('screenWidth: $screenWidth');
    appLogs('screenHeight: $screenHeight');

    if (screenWidth > 300 && screenWidth < 500) {
      defaultScreenWidth = 450;
      defaultScreenHeight = defaultScreenWidth * screenHeight / screenWidth;
    } else if (screenWidth > 500 && screenWidth < 600) {
      defaultScreenWidth = 500;
      defaultScreenHeight = defaultScreenWidth * screenHeight / screenWidth;
    } else if (screenWidth > 600 && screenWidth < 700) {
      defaultScreenWidth = 550;
      defaultScreenHeight = defaultScreenWidth * screenHeight / screenWidth;
    } else if (screenWidth > 700 && screenWidth < 1050) {
      defaultScreenWidth = 800;
      defaultScreenHeight = defaultScreenWidth * screenHeight / screenWidth;
    } else {
      defaultScreenWidth = screenWidth;
      defaultScreenHeight = screenHeight;
    }

    print('''
    ========Device Screen Details===============
    screenWidth: $screenWidth
    screenHeight: $screenHeight
    
    defaultScreenWidth: $defaultScreenWidth
    defaultScreenHeight: $defaultScreenHeight
    ''');

    ScreenUtil.init(
      context,
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    );

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    s1 = ScreenUtil().setWidth(1);
    s2 = ScreenUtil().setWidth(2);
    s3 = ScreenUtil().setWidth(3);
    s4 = ScreenUtil().setWidth(4);
    s5 = ScreenUtil().setWidth(5);
    s6 = ScreenUtil().setWidth(6);
    s8 = ScreenUtil().setWidth(8);
    s10 = ScreenUtil().setWidth(10);
    s12 = ScreenUtil().setWidth(12);
    s14 = ScreenUtil().setWidth(14);
    s15 = ScreenUtil().setWidth(15);
    s16 = ScreenUtil().setWidth(16);
    s18 = ScreenUtil().setWidth(18);
    s20 = ScreenUtil().setWidth(20);
    s25 = ScreenUtil().setWidth(25);
    s30 = ScreenUtil().setWidth(30);
    s40 = ScreenUtil().setWidth(40);
    s50 = ScreenUtil().setWidth(50);
    s60 = ScreenUtil().setWidth(60);
    s70 = ScreenUtil().setWidth(70);
    s80 = ScreenUtil().setWidth(80);
    s100 = ScreenUtil().setWidth(100);
    s120 = ScreenUtil().setWidth(120);
    s150 = ScreenUtil().setWidth(150);
    s165 = ScreenUtil().setWidth(165);
    s200 = ScreenUtil().setWidth(200);
    s300 = ScreenUtil().setWidth(300);

    /*EdgeInsets*/

    spacingAllDefault = EdgeInsets.all(s8);
    spacingAllSmall = EdgeInsets.all(s10);
    spacingAllExtraSmall = EdgeInsets.all(s10);

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil().setWidth(25);
    defaultImageHeight = ScreenUtil().setWidth(100);
    defaultCardHeight = ScreenUtil().setWidth(120);
    defaultImageRadius = ScreenUtil().setWidth(40);
    snackBarHeight = ScreenUtil().setWidth(50);
    texIconSize = ScreenUtil().setWidth(30);
    circularImageRadius = ScreenUtil().setWidth(36);
    appBarHeight = ScreenUtil().setWidth(235);

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil().setHeight(5);
    alertHeight = ScreenUtil().setWidth(200);
    minWidthAlertButton = ScreenUtil().setWidth(70);
  }
}

class FontSize {
  static double s7 = 7;
  static double s8 = 8;
  static double s9 = 9;
  static double s10 = 10;
  static double s11 = 11;
  static double s12 = 12;
  static double s13 = 13;
  static double s14 = 14;
  static double s15 = 15;
  static double s16 = 16;
  static double s17 = 17;
  static double s18 = 18;
  static double s19 = 19;
  static double s20 = 20;
  static double s21 = 21;
  static double s22 = 22;
  static double s23 = 23;
  static double s24 = 24;
  static double s25 = 25;
  static double s26 = 26;
  static double s27 = 27;
  static double s28 = 28;
  static double s29 = 29;
  static double s30 = 30;
  static double s36 = 36;

  static setDefaultFontSize() {
    s7 = 7;
    s8 = 8;
    s9 = 9;
    s10 = 10;
    s11 = 11;
    s12 = 12;
    s13 = 13;
    s14 = 14;
    s15 = 15;
    s16 = 16;
    s17 = 17;
    s18 = 18;
    s19 = 19;
    s20 = 20;
    s21 = 21;
    s22 = 22;
    s23 = 23;
    s24 = 24;
    s25 = 25;
    s26 = 26;
    s27 = 27;
    s28 = 28;
    s29 = 29;
    s30 = 30;
    s36 = 36;
  }

  static setScreenAwareFontSize() {
    s7 = ScreenUtil().setSp(7);
    s8 = ScreenUtil().setSp(8);
    s9 = ScreenUtil().setSp(9);
    s10 = ScreenUtil().setSp(10);
    s11 = ScreenUtil().setSp(11);
    s12 = ScreenUtil().setSp(12);
    s13 = ScreenUtil().setSp(13);
    s14 = ScreenUtil().setSp(14);
    s15 = ScreenUtil().setSp(15);
    s16 = ScreenUtil().setSp(16);
    s17 = ScreenUtil().setSp(17);
    s18 = ScreenUtil().setSp(18);
    s19 = ScreenUtil().setSp(19);
    s20 = ScreenUtil().setSp(20);
    s21 = ScreenUtil().setSp(21);
    s22 = ScreenUtil().setSp(22);
    s23 = ScreenUtil().setSp(23);
    s24 = ScreenUtil().setSp(24);
    s25 = ScreenUtil().setSp(25);
    s26 = ScreenUtil().setSp(26);
    s27 = ScreenUtil().setSp(27);
    s28 = ScreenUtil().setSp(28);
    s29 = ScreenUtil().setSp(29);
    s30 = ScreenUtil().setSp(30);
    s36 = ScreenUtil().setSp(36);
  }
}
