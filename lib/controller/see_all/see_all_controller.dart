import '../manage_users/manage_users_controller.dart';
import '/models/provider_model.dart';
import 'package:get/get.dart';

class SeeAllController extends GetxController {
  late List<ProviderModel> providers;
  String title = '';

  @override
  void onInit() {
    providers = Get.arguments['providers'];
    title = Get.arguments['title'];
    super.onInit();
  }

  toggleFavorites(String provId) async {
    final savedController = UsersController();
    await savedController.onTapFavorite(provId);
    update();
  }
}
