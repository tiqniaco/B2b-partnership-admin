import '/controller/request_services/service_request_details_controller.dart';
import '/core/services/app_prefs.dart';
import '/core/theme/app_color.dart';
import '/models/price_offer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PriceOfferWidget extends GetView<ServiceRequestDetailsController> {
  const PriceOfferWidget({super.key, required this.model});
  final ModelData model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            title: "Description",
            titleStyle: TextStyle(fontSize: 13.sp),
            content: Text(model.offerDescription!,
                style: TextStyle(fontSize: 13.sp)));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: greyCart,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(imageUrl: model.providerImage!)),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.providerName!,
                    style: TextStyle(fontSize: 15.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${model.requestOfferPrice!} \$",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: primaryColor),
                  ),
                ],
              ),
            ),
            Gap(10),
            Get.find<AppPreferences>().getUserRole() == "client"
                ? model.requestOfferStatus == 'accepted'
                    ? Container(
                        width: 90,
                        height: 26.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: greyColor,
                        ),
                        child: Text(
                          "Accepted",
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ))
                    : SizedBox(
                        width: 90,
                        height: 26.h,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(horizontal: 10)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            onPressed: () {
                              // controller
                              // .acceptPriceOffers(model.requestOfferId!);
                            },
                            child: Text(
                              "Accept",
                              style: TextStyle(fontSize: 11.sp),
                            )),
                      )
                : Row(
                    children: [
                      Container(
                          width: 90,
                          height: 26.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: greyColor,
                          ),
                          child: Text(
                            model.requestOfferStatus!,
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                          )),
                      IconButton(
                          onPressed: () {
                            //controller.deleteOffer(model.requestOfferId!);
                          },
                          icon: Icon(Icons.close))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
