// import '/controller/auth/signup_controller.dart';
// import '/core/theme/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class CustomPhoneWidget extends StatelessWidget {
//   const CustomPhoneWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get.put(SignupController());
//     return GetBuilder<SignupController>(builder: (controller) {
//       return Directionality(
//         textDirection: TextDirection.ltr,
//         child: TextFormField(
//           keyboardType: TextInputType.phone,
//           controller: controller.phoneController,
//           maxLength: int.parse(controller.selectedCountry.phoneLength!),
//           decoration: InputDecoration(
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             label: Text(
//               "Phone",
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 17.sp,
//                   color: Colors.black87),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
//             prefixIcon: SizedBox(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Gap(5),
//                   Icon(
//                     Icons.arrow_drop_down_sharp,
//                     color: blackColor,
//                   ),
//                   Gap(5),
//                   Image.network(
//                     controller.selectedCountry.flag!,
//                     width: 23.h,
//                     height: 23.h,
//                     fit: BoxFit.cover,
//                   ),
//                   Gap(6),
//                   Text("+${controller.selectedCountry.code}"),
//                   Gap(8),
//                   Container(
//                     width: 2,
//                     height: 25.h,
//                     color: pageColor,
//                   ),
//                   Gap(10)
//                 ],
//               ),
//             ),
//             hintText: "Without country code".tr,
//             hintStyle: TextStyle(
//                 fontSize: 12.sp,
//                 color: greyColor.withAlpha(160),
//                 fontWeight: FontWeight.w500),
//             focusedBorder:
//                 OutlineInputBorder(borderSide: BorderSide(color: blackColor)),
//           ),
//         ),
//       );
//     });
//   }
// }
