// ignore_for_file: avoid_print

import '/controller/provider/my_services/get_my_service_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/service_feature_model.dart';
import '/models/services_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceDetailsController extends GetxController {
  bool isOverView = true;
  bool isSeller = false;

  late int serviceId;
  List<ServiceFeatureModel> serviceFeatures = [];
  ServiceModel? service;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestFeature = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;

  @override
  void onInit() {
    serviceId = int.parse(Get.arguments['id']);
    getService();
    getServiceFeature();
    // getServiceReview();
    super.onInit();
  }

  onTapOverView() {
    isOverView = true;
    isSeller = false;

    update();
  }

  onTapSeller() {
    isOverView = false;
    isSeller = true;

    update();
  }

  Future<void> getService() async {
    print("get details .........");
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ServiceModel>(
      path: ApiConstance.getServiceDetails(serviceId.toString()),
      fromJson: (json) {
        return ServiceModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      service = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  Future<void> getServiceFeature() async {
    print("get features .........");
    statusRequestFeature = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getFeatureServices,
        data: {"provider_service_id": serviceId},
        fromJson: (json) {
          return json['data']
              .map<ServiceFeatureModel>(
                  (type) => ServiceFeatureModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestFeature = StatusRequest.error;
      print("==================================");
      Logger().e(l.errMsg);
    }, (r) {
      serviceFeatures.clear();
      statusRequestFeature = StatusRequest.success;
      serviceFeatures = r;

      if (r.isEmpty) {
        statusRequestFeature = StatusRequest.noData;
      } else {
        statusRequestFeature = StatusRequest.success;
      }
    });
    update();
  }

  contactMethods() {
    Get.defaultDialog(
        titleStyle: getMediumStyle,
        title: "Contact with",
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              if (service?.provider?.contactPhone != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('tel://${service?.provider?.contactPhone}');
                  },
                  icon: FontAwesomeIcons.phone,
                  value: service?.provider?.contactPhone ?? "",
                  iconColor: Colors.green,
                ),
              if (service?.provider?.contactEmail != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('mailto://${service?.provider?.contactEmail}');
                  },
                  icon: FontAwesomeIcons.envelope,
                  value: service?.provider?.contactEmail ?? "",
                  iconColor: Colors.red,
                ),
              if (service?.provider?.contactWhatsapp != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL(
                      'https://wa.me/+${service?.provider?.contactWhatsapp}',
                    );
                  },
                  icon: FontAwesomeIcons.whatsapp,
                  value: service?.provider?.contactWhatsapp ?? "",
                  iconColor: whatsappColor,
                ),
              if (service?.provider?.contactTelegram != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('${service?.provider?.contactTelegram}');
                  },
                  icon: FontAwesomeIcons.telegram,
                  value: service?.provider?.contactTelegram ?? "",
                  iconColor: telegramColor,
                ),
              if (service?.provider?.contactInstagram != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('${service?.provider?.contactInstagram}');
                  },
                  icon: FontAwesomeIcons.instagram,
                  value: "Instagram",
                  iconColor: instagramColor,
                ),
              if (service?.provider?.contactFacebook != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('${service?.provider?.contactFacebook}');
                  },
                  icon: FontAwesomeIcons.facebook,
                  value: "Facebook",
                  iconColor: facebookColor,
                ),
              if (service?.provider?.contactLinkedin != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL('${service?.provider?.contactLinkedin}');
                  },
                  icon: FontAwesomeIcons.linkedin,
                  value: "LinkedIn",
                  iconColor: linkedinColor,
                ),
              if (service?.provider?.contactWebsite != null)
                ProviderContactMethodWidget(
                  onTap: () {
                    _launchURL(service?.provider?.contactWebsite ?? "");
                  },
                  icon: Icons.web,
                  value: service?.provider?.contactWebsite ?? "",
                  iconColor: Colors.blue,
                ),
              Gap(10.h),
            ],
          ),
        ));
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not launch $url');
    }
  }

  void deleteServiceDialog() {
    Get.defaultDialog(
      title: "Delete Service",
      middleText: "Are you sure you want to delete this service?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: _deleteService,
    );
  }

  void _deleteService() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteProviderService(service?.data?.id ?? ""),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        Get.back();
        Get.put(GetMyServiceController()).getServices();
        AppSnackBars.success(message: data);
      },
    );
  }
}

class ProviderContactMethodWidget extends StatelessWidget {
  const ProviderContactMethodWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.onTap,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final void Function()? onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15.sp,
                backgroundColor: iconColor,
                child: Icon(
                  icon,
                  size: 13.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
