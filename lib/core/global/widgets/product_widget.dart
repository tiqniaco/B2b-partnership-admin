// import '/core/localization/app_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '/core/global/widgets/custom_network_image.dart';
// import '/core/theme/app_color.dart';
// import '/core/theme/text_style.dart';
// import '../../../app_routes.dart';

// // ignore: must_be_immutable
// class ProductWidget extends StatelessWidget {
//   const ProductWidget({
//     super.key,
//     this.product,
//   });

//   final ProductModel? product;

//   // bool isFavorite;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(6.w),
//       onTap: () {
//         Get.toNamed(
//           AppRoutes.productDetails,
//           arguments: {
//             'productName': product?.nameEn ?? '',
//             'productId': product?.id ?? 0,
//           },
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: whiteColor,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: greyColor.withOpacity(0.2),
//           ),
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: 10.w,
//           vertical: 8.h,
//         ),
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: 1.sw,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 6.w,
//                       vertical: 6.h,
//                     ),
//                     child: CustomNetworkImage(
//                       imageUrl: product?.image ?? '',
//                     ),
//                   ),
//                 ),
//                 Gap(5.h),
//                 Text(
//                   product?.nameEn ?? '',
//                   style: getBoldStyle.copyWith(
//                     fontSize: 14.sp,
//                     color: secondaryColor,
//                   ),
//                   maxLines: 3,
//                 ),
//                 Gap(5.h),
//                 Text(
//                   '${product?.price ?? 200} ${AppStrings.EGP.tr}',
//                   style: getBoldStyle.copyWith(
//                     fontSize: 12.sp,
//                     color: primaryColor,
//                   ),
//                   textAlign: TextAlign.start,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
