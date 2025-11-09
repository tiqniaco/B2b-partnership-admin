import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppPdfView extends StatefulWidget {
  const AppPdfView({super.key, required this.url});
  final String url;

  @override
  State<AppPdfView> createState() => _AppPdfViewState();
}

class _AppPdfViewState extends State<AppPdfView> {
  int currentPage = 0;
  int totalPages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.isTablet ? 50.h : null,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: whiteColor),
        title: Text(
          "PDF Viewer",
          style: getMediumStyle.copyWith(
            color: whiteColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Text(
            "${currentPage + 1} ${Get.locale?.languageCode == "en" ? "of" : "من"} $totalPages",
            style: getRegularStyle.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
        ],
      ),
      body: Center(
        child: PDF(
          enableSwipe: true,
          onError: (error) {
            debugPrint(error.toString());
          },
          onRender: (pages) {
            setState(() {
              currentPage = 0;
              totalPages = pages!;
            });
          },
          onPageChanged: (index, total) {
            setState(() {
              currentPage = index!;
              totalPages = total!;
            });
          },
          onPageError: (page, error) {
            debugPrint('$page: ${error.toString()}');
          },
        ).cachedFromUrl(
          widget.url,
          placeholder: (progress) {
            return Center(
              child: CircularProgressIndicator(
                value: progress,
              ),
            );
          },
          errorWidget: (dynamic error) {
            return Center(
              child: Text(error.toString()),
            );
          },
        ),
      ),
    );
  }
}
