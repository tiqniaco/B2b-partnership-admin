import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextformWidget extends StatelessWidget {
  const AuthTextformWidget(
      {super.key,
      required this.hintText,
      this.textFormController,
      this.validator,
      this.keyboardType,
      this.icon,
      this.color = Colors.black,
      this.prefixIcon,
      this.suffixIcon
      //required this.labal,
      });
  final Color color;
  final String hintText;
  final IconData? icon;
  final TextEditingController? textFormController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: null,
        keyboardType: keyboardType,
        validator: validator,
        controller: textFormController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          label: Text(
            hintText,
            style: TextStyle(fontSize: 14.sp),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: Icon(suffixIcon),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
        ));
  }
}
