import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/utils/assets_data.dart';
// import 'package:shimmer/shimmer.dart';
import '/core/theme/app_color.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fitHeight,
    this.width,
    this.height,
    this.shape,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius:
            shape == BoxShape.circle ? null : BorderRadius.circular(5.r),
        image: DecorationImage(
          image: Image.network(imageUrl).image,
          fit: fit,
        ),
        shape: shape ?? BoxShape.rectangle,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image(
        image: Image.network(imageUrl).image,
        fit: fit,
        alignment: Alignment.center,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Image.asset(
            AssetsData.defaultImage,
            fit: fit,
            alignment: Alignment.center,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.error,
            color: dangerColor,
            size: 10.h,
          );
        },
      ),
    );
  }
}
