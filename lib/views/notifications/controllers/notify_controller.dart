import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/models/notification_model.dart';
import 'package:get/get.dart';

class NotifyController extends GetxController {
  int selectedIndex = 0;
  StatusRequest statusRequest = StatusRequest.loading;
  List<NotificationModel> notifications = [];

  @override
  onInit() async {
    await getNotifications();
    super.onInit();
  }

  Future<void> getNotifications() async {
    notifications.clear();
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<NotificationModel>>(
      path: ApiConstance.getNotifications,
      fromJson: (json) {
        return List<NotificationModel>.from(
          json['data'].map(
            (x) => NotificationModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();
    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
      },
      (data) {
        if (data.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
          notifications = data;
        }
        update();
      },
    );
  }
}
