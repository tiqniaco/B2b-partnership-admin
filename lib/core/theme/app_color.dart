// This file contains all the colors used in the app

// ignore_for_file: deprecated_member_use

// Primary color
import '/core/functions/build_material_color.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xffbe0000); // 821115
const secondaryColor = Color(0xffA9181D);
const thirdColor = Color.fromARGB(255, 223, 66, 71);
Color borderColor = Colors.grey.withAlpha(50);

const redColor = Color(0xffF43F5F);

const orangColor = Color.fromARGB(255, 250, 153, 6);
// const primaryColor = Color(0xff00ce7c);

//------------------

const orangeColor = Color(0xffda911e);
const lightBabyBlueColor = Color(0xffb2d1ed);
const babyBlueColor = Color(0xff8eabd3);
const deepBabyBlueColor = Color(0xff5c6e94);
const purpleColor = Color(0xff7b6caf);
//const redColor = Color(0xffd15136);
const pinkColor = Color(0xffea908f);
const pageColor = Color.fromARGB(255, 224, 220, 220);
const greenColor = Color(0xff7e8d36);
const blueColor = Colors.blue;
// my colors   //  #B59C65
const testBackg = Color(0xffD1E2F5);
const deepBaby = Color(0xff6D8CC1);
const lightBaby = Color(0xffB2D2ED);
const baby = Color(0xffB2D2ED);
const redBaby = Color(0xffEB9190);
const green = Color(0xff829438);
const orange = Color(0xffDF951D);
const deepRed = Color(0xffCB5037);
const brawen = Color(0xffB59C65);
const greyCart = Color(0xffF5F6FA);
//------------------

//const secondaryColor = Color(0xff05414b);
const bottomBarColor = Color(0xff2E3C33);
const lightPrimaryColor = Color(0xffc9f7e3);
const darkPrimaryColor = Color.fromARGB(255, 84, 135, 2);
// const darkPrimaryColor = Color(0xff00a650);
const selectedBNavBackgroundColor = Color.fromRGBO(255, 255, 255, 0.16);
const unSelectedBNavColor = Color(0xff879797);

// Background color
const backgroundColor = Color(0xFFf1f5f7);
const secondBackgroundColor = Color(0xFFf7f7f7);
final lightGreyBackgroundColor = Colors.grey[100];

// Text color
const blackColor = Color(0xFF000000);
const lightTextColor = Color(0xFF535353);
final blackWithOpacityColor = const Color(0xFF000000).withOpacity(0.5);

// Other colors
const whiteColor = Color(0xFFFFFFFF);
const greyColor = Color(0xFF9A9A9D);
const textFormFieldFilledColor = whiteColor; // Color(0xFFededed);
const lightGreyColor = Color(0xFFf7f7f7);
// const borderColor = Color(0xFFdbdbdb);
const dividerColor = Color(0xFFe7e7e7);
const starColor = Color(0xFFffcc00);

// Material color
MaterialColor primarySwatchColor = buildMaterialColor(primaryColor);

// Transparent color
const Color transparentColor = Colors.transparent;

// Status colors
const Color successColor = Color(0xff4caf50);
const Color dangerColor = Color(0xffdc3545);
const Color warningColor = Color(0xffffcc00);

// Hint color
const Color hintColor = Color(0xffaeaeae);

// Privacy text color
const Color privacyTextColor = Color(0xff5a5b78);

// Button colors
const Color lightButtonColor = Color(0xffd9d9d9);

// Doctor availability colors
const Color availableColor = Color(0xff9fcfa7);
const Color availableBackgroundColor = Color(0xffc2e5c7);
const Color notAvailableColor = dangerColor;
const Color notAvailableBackgroundColor = Color(0xfff0d9d9);

// Social media colors
const Color whatsappColor = Color(0xff25d366);
const Color emailColor = Color(0xff0077b5);
const Color telegramColor = Color(0xff2ca5e0);
const Color instagramColor = Color(0xffe1306c);
const Color facebookColor = Color(0xff3b5998);
const Color linkedinColor = Color(0xff0a66c2);

// Gradient color for login button
const LinearGradient loginButtonGradientColor = LinearGradient(
  begin: AlignmentDirectional.centerStart,
  end: AlignmentDirectional.centerEnd,
  colors: [
    primaryColor,
    darkPrimaryColor,
  ],
);
