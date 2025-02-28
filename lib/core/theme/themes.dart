import 'package:flutter/material.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '../utils/font_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static ThemeData get light => ThemeData(
        /// Define the default brightness and colors.
        primarySwatch: primarySwatchColor,
        primaryColor: primaryColor,
        fontFamily: FontManager.defaultFontFamily,
        scaffoldBackgroundColor: whiteColor, // backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimary: whiteColor,
          secondary: primaryColor,
          onSecondary: whiteColor,
          error: dangerColor,
          onError: whiteColor,
          surface: whiteColor,
          onSurface: blackColor,
          brightness: Brightness.light,
        ),

        /// Define the default app bar theme.
        appBarTheme: ThemeData.light(useMaterial3: true).appBarTheme.copyWith(
              backgroundColor: backgroundColor,
              centerTitle: false,
              foregroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
              titleTextStyle: getBoldStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: blackColor,
                fontFamily: FontManager.defaultFontFamily,
              ),
              elevation: 0,
              iconTheme: ThemeData.light().iconTheme.copyWith(
                    color: blackColor,
                  ),
              actionsIconTheme: ThemeData.light().iconTheme.copyWith(
                    color: blackColor,
                  ),
            ),

        /// Define the default text form field theme.
        textSelectionTheme: ThemeData.light().textSelectionTheme.copyWith(
              cursorColor: primaryColor,
              selectionColor: primaryColor,
              selectionHandleColor: primaryColor,
            ),

        /// Define the default text form field theme.
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: getRegularStyle.copyWith(
            fontSize: 16.sp,
            color: blackWithOpacityColor,
          ),
          labelStyle: getRegularStyle.copyWith(
            fontSize: 15.sp,
            color: blackColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.w),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: dangerColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: dangerColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.w),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.w),
          ),
          filled: false,
          fillColor: textFormFieldFilledColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 15.w,
          ),
        ),

        /// Define the default elevated button theme.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            surfaceTintColor: primaryColor,
            foregroundColor: whiteColor,
            fixedSize: Size(100.w, 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontManager.mediumFontWeight,
              color: whiteColor,
              fontFamily: FontManager.defaultFontFamily,
            ),
          ),
        ),

        /// Define the default card theme.
        cardColor: whiteColor,
        cardTheme: CardTheme(
          color: whiteColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.w),
          ),
          surfaceTintColor: whiteColor,
        ),

        /// Define the default bottom nav theme.
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: whiteColor,
          elevation: 10.w,
          selectedIconTheme: const IconThemeData(
            color: primaryColor,
          ),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontManager.boldFontWeight,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            color: greyColor,
            fontWeight: FontManager.regularFontWeight,
            fontSize: 12.sp,
          ),
          unselectedItemColor: greyColor,
        ),

        /// Define the default divider theme.
        dividerColor: dividerColor,
        dividerTheme: const DividerThemeData(
          color: dividerColor,
        ),
      );
}
