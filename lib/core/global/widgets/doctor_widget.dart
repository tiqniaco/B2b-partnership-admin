// import '/app_routes.dart';
// import '/core/localization/app_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// import '/core/global/widgets/custom_network_image.dart';
// import '/core/theme/app_color.dart';
// import '/core/theme/text_style.dart';

// class DoctorWidget extends StatelessWidget {
//   const DoctorWidget({
//     super.key,
//     this.routName,
//     this.btnText,
//     this.model,
//     this.onPressed,
//   });

//   final String? routName;
//   final String? btnText;
//   final DoctorModel? model;
//   final void Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.toNamed(
//           routName ?? AppRoutes.doctorDetails,
//           arguments: {
//             "id": model?.id.toString() ?? "",
//             "doctorId": model?.id.toString() ?? "",
//             "doctorName": model?.name ?? "",
//           },
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: whiteColor,
//         ),
//         padding: EdgeInsets.all(15.w),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 0.2.sw,
//                   height: 0.15.sw,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: primaryColor,
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: CustomNetworkImage(
//                     imageUrl: model?.image ??
//                         "https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg",
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       model?.name ?? "Ahlam Magdy",
//                       style: getBoldStyle.copyWith(
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     Text(
//                       Get.locale!.languageCode == 'en'
//                           ? model?.department.nameEn ?? ""
//                           : model?.department.nameAr ?? "",
//                       style: getMediumStyle.copyWith(
//                         fontSize: 14.sp,
//                         color: greyColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     IconButton(
//                         onPressed: onPressed, icon: const Icon(Icons.delete)),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8.w,
//                         vertical: 2.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: backgroundColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 16.w,
//                           ),
//                           SizedBox(
//                             width: 3.w,
//                           ),
//                           Text(model?.rating.toString() ?? 4.9.toString())
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 14.h,
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 10.w,
//                 vertical: 3.h,
//               ),
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               AppStrings.phoneNumber.tr,
//                               style: getBoldStyle.copyWith(
//                                 fontSize: 14.sp,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   FontAwesomeIcons.phone,
//                                   size: 10.w,
//                                   color: primaryColor,
//                                 ),
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Text(
//                                   model?.phone ?? "0123456789",
//                                   style: getRegularStyle.copyWith(
//                                     fontSize: 13.sp,
//                                     color: primaryColor,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Container(
//                           width: 1.5.w,
//                           height: 25.h,
//                           color: greyColor.withOpacity(0.6),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${model?.consultationFee ?? 200} ${AppStrings.EGP.tr}",
//                               style: getBoldStyle.copyWith(
//                                 fontSize: 14.sp,
//                               ),
//                             ),
//                             Text(
//                               AppStrings.consultationFees.tr,
//                               style: getRegularStyle.copyWith(
//                                 fontSize: 13.sp,
//                                 color: greyColor,
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(
//                     height: 8.h,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
