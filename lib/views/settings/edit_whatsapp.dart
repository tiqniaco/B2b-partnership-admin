import 'package:b2b_partnership_admin/controller/settings/edit_whatsapp_controller.dart';

import '/core/global/widgets/custom_loading_button.dart';

import '/widgets/auth/auth_text_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditWhatsapp extends StatelessWidget {
  const EditWhatsapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditWhatsappController>(
      init: EditWhatsappController(),
      builder: (EditWhatsappController controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Edit Whatsapp Number".tr),
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          AuthTextForm(
                            lable: "Whatsapp".tr,
                            preicon: CupertinoIcons.person,
                            hintText: "enter whatsapp number".tr,
                            textFormController: controller.numberController,
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              height: 0.081.sh,
              child: CustomLoadingButton(
                onPressed: () {
                  return controller.updateWhats();
                },
                text: "Update".tr,
              ),
            ));
      },
    );
  }
}
