import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/complaints/complaints_users_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/models/complaints_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ComplaintsUsersView extends StatefulWidget {
  const ComplaintsUsersView({super.key});

  @override
  State<ComplaintsUsersView> createState() => _ComplaintsUsersViewState();
}

class _ComplaintsUsersViewState extends State<ComplaintsUsersView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsUsersController>(
      init: ComplaintsUsersController(),
      builder: (ComplaintsUsersController controller) {
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Complaints".tr),
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    text: "Clients".tr,
                  ),
                  Tab(
                    text: "Providers".tr,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                CustomServerStatusWidget(
                  statusRequest: controller.statusRequestClients,
                  child: RefreshIndicator(
                    onRefresh: () => controller.getClientsComplaints(),
                    child: UserComplaintsListWidget(
                      users: controller.clients,
                    ),
                  ),
                ),
                CustomServerStatusWidget(
                  statusRequest: controller.statusRequestProviders,
                  child: RefreshIndicator(
                    onRefresh: () => controller.getProvidersComplaints(),
                    child: UserComplaintsListWidget(
                      users: controller.providers,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserComplaintsListWidget extends StatelessWidget {
  const UserComplaintsListWidget({
    super.key,
    required this.users,
  });

  final List<ComplaintsUserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        onTap: () => Get.toNamed(
          AppRoutes.complaints,
          arguments: {
            "userId": users[index].id,
          },
        ),
        leading: CircleAvatar(
          radius: 24.r,
          backgroundImage: NetworkImage(
            users[index].image,
          ),
        ),
        title: Text(users[index].name),
        subtitle: Text(users[index].email),
        trailing: CircleAvatar(
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.phone,
              color: whiteColor,
              size: 16.sp,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: "Phone".tr,
                content: Text(
                  "+${users[index].countryCode + users[index].phone}",
                ),
                textCancel: "Close".tr,
                textConfirm: "Call".tr,
                onConfirm: () {
                  launchUrlString(
                    "tel:+${users[index].countryCode + users[index].phone}",
                  );
                },
              );
            },
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }
}
