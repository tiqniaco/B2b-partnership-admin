import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextformWidget extends StatelessWidget {
  const TextformWidget({
    super.key,
    required this.hintText,
    this.textFormController,
    this.validator,
    this.keyboardType,
    this.icon,
    this.color = Colors.black,
    this.enabled = true,
    this.onSubmit,
    this.maxLine,
    //required this.labal,
  });
  final Color color;
  final String hintText;
  final IconData? icon;
  final TextEditingController? textFormController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final Function(String? value)? onSubmit;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        maxLines: maxLine,
        keyboardType: keyboardType,
        validator: validator,
        controller: textFormController,
        onFieldSubmitted: onSubmit,
        onChanged: onSubmit,
        decoration: InputDecoration(
          label: Text(
            hintText,
            style: TextStyle(fontSize: 14.sp),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
        ));
  }
}
