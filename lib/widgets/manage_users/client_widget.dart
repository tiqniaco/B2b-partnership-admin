import 'package:b2b_partnership_admin/controller/manage_users/manage_clients_controller.dart';
import 'package:b2b_partnership_admin/models/client_model.dart';
import 'package:flutter/cupertino.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientWidget extends StatelessWidget {
  ClientWidget({super.key, required this.clients});
  final List<ClientModel> clients;

  final controller = Get.put(ManageClientsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageClientsController>(
        builder: (controller) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.vertical,
            itemCount: clients.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 90,
            ),
            itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pageColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: Colors.grey.withAlpha(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: clients[index].image!,
                                height: 40.h,
                                width: 40.h,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(CupertinoIcons.person),
                                ),
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  clients[index].name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "+${clients[index].countryCode!}${clients[index].phone!}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: greyColor,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                controller
                                    .deleteClient(clients[index].clientId!);
                              },
                              child: Icon(Icons.remove_circle,
                                  color: primaryColor, size: 25.sp)),
                          Gap(5)
                        ],
                      ),
                    ],
                  ),
                )));
  }
}
