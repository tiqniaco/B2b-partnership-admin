import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget buildTextField(
  TextEditingController controller,
  String label,
  IconData icon,
  String hintText,
  String Function(String?) validator, {
  bool hasValidation = true,
  double? labelWidth,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13.sp, color: greyColor),
        label: Column(
          children: [
            Container(
              width: labelWidth ?? 175.w,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              child: Text(
                label,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Gap(35)
          ],
        ),
        filled: true,
        fillColor: whiteColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: null,
      validator: hasValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            }
          : null,
    ),
  );
}
