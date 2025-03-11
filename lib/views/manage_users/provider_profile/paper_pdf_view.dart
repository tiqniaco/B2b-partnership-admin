import 'package:b2b_partnership_admin/controller/manage_users/provider_profile/pdf_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaperPdfView extends StatelessWidget {
  const PaperPdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close, size: 30.sp)),
      ),
      body: GetBuilder<PdfViewController>(
          init: PdfViewController(),
          builder: (controller) {
            return PDF().cachedFromUrl(
              controller.file,
              placeholder: (progress) => Center(child: Text('loading...')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            );
          }),
    );
  }
}
