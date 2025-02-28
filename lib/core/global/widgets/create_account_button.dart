
import '/core/global/widgets/custom_loading_button.dart';

import '/core/localization/app_strings.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
   // required this.controller,
  });

 // final AllPatientsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.12.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: backgroundColor,
              width: 3.h,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 11.h,
        ),
        child: CustomLoadingButton(
          onPressed: () {
            //return controller.addPatient();
          },
          text: AppStrings.createAccount.tr,
        )
        
        );
  }
}
