import 'package:b2b_partnership_admin/views/manage_categories/manage_categories_view.dart';
import 'package:b2b_partnership_admin/views/manage_location/manage_location_view.dart';
import 'package:b2b_partnership_admin/views/manage_provider_typies/manage_provider_types_view.dart';
import 'package:b2b_partnership_admin/views/shop/products/shop_add_new_product_view.dart';

import '/views/auth/forget_password_email_view.dart';
import '/views/auth/forget_password_reset_view.dart';
import '/views/auth/login_view.dart';
import '/views/auth/o_t_p_view.dart';
import 'views/home/admin_home_layout.dart';
import 'views/home/admin_home_view.dart';
import '/views/orders/orders_view.dart';
// import '/views/provider_app/home/provider_home_layout.dart';
// import '/views/provider_app/home/provider_home_view.dart';
import '/views/provider_profile/previous_work_view.dart';
import '/views/provider_profile/provider_profile_view.dart';
import '/views/see_all/see_all_categories.dart';
import '/views/service_details_view.dart';
import '/views/in_category/providers_in_categories.dart';
import '/views/service_request/add_service_request.dart';
import '/views/service_request/get_user_service_request.dart';
import '/views/settings/change_password_view.dart';
import '/views/settings/edit_client_profile_view.dart';
import '/views/shop/shop_cart_view.dart';
import '/views/shop/shop_view.dart';
import '/views/splash/views/splash_view.dart';
import 'package:get/get.dart';

import 'views/complaints/complaints_view.dart';
import 'views/notifications/views/notification_view.dart';
import 'views/orders/order_details_view.dart';
import 'views/orders/order_item_view.dart';
import 'views/provider_app/my_services/add_provider_service_view.dart';
import 'views/provider_app/my_services/edit_provider_service_view.dart';
import 'views/provider_app/setting/edit_provider_profile_view.dart';
import 'views/provider_app/setting/provider_contacts/provider_contacts_view.dart';
import 'views/search/search_view.dart';
import 'views/service_request/service_request_details.dart';
import 'views/shop/categories/shop_add_new_category_view.dart';
import 'views/shop/categories/shop_edit_category_view.dart';
import 'views/shop/products/shop_edit_product_view.dart';
import 'views/shop/products/shop_product_details_view.dart';

class AppRoutes {
  /// Base routes
  static const String initial = '/';
  static const String onboarding = '/onboarding';

  /// Auth routes
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String otp = '/otp';
  static const String forgetPasswordReset = '/forget-password-reset';
  static const String resetPassword = '/reset-password';
  static const String checkEmail = "/check-email";
  static const String loginByPassword = "/login-by-password";

  // home
  static const String clintHome = '/clintHome';
  static const String providerHomeLayout = '/providerHomeLayout';
  static const String providerHomeView = '/providerHomeView';
  static const String adminHomeLayout = '/clientHomeLayout';
  static const String seeAll = '/seeAll';
  static const String seeAllCategories = '/seeAllCategories';

  //admin
  static const String manageCategory = '/manageCategory';
  static const String manageProviderTypes = '/manageProviderTypes';
  static const String manageLocations = '/manageLocations';

  //service request
  static const String addServicesRequest = '/addServicesRequest';
  static const String getRequestServices = '/requestServices';
  static const String serviceRequestDetails = '/serviceRequestDetails';

  // service details
  static const String serviceDetails = '/serviceDetails';
  static const String providersInCategory = '/providersInCategory';

  // provider
  static const String providerProfile = '/providerProfile';
  static const String providerPreviousWork = '/providerPreviousWork';

  // Shop
  static const String shop = '/shop';
  static const String shopProductDetails = '/shopProductDetails';
  static const String shopCart = '/shopCart';
  static const String shopOrders = '/orders';
  static const String shopAddNewProduct = '/shopAddNewProduct';
  static const String shopEditProduct = '/shopEditProduct';
  static const String shopAddNewCategory = '/shopAddNewCategory';
  static const String shopEditCategory = '/shopEditCategory';

  // Edit Client Profile
  static const String editClientProfile = '/editClientProfile';
  static const String changePassword = '/changePassword';

  // Complaints
  static const String complaints = '/complaints';

  // Notification
  static const String notification = '/notification';

  static const String search = '/search';

  // Order Details
  static const String orderDetails = '/orderDetails';
  static const String orderItem = '/orderItem';

  // Edit Provider Profile
  static const String editProviderProfile = "/edit-provider-profile";
  static const String addProviderService = "/add-provider-service";
  static const String editProviderService = "/edit-provider-service";

// Provider Contacts
  static const String providerContacts = '/providerContacts';

  static final List<GetPage<dynamic>> pages = [
    // base
    GetPage(
      name: initial,
      page: () => const SplashView(),
    ),
    // auth
    GetPage(
      name: login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: forgetPassword,
      page: () => const ForgetPasswordEmailView(),
    ),
    GetPage(
      name: otp,
      page: () => const OTPView(),
    ),
    GetPage(
      name: forgetPasswordReset,
      page: () => const ForgetPasswordResetView(),
    ),

    //home

    GetPage(
      name: clintHome,
      page: () => AdminHomeView(),
    ),
    // GetPage(
    //   name: providerHomeView,
    //   page: () =>  ProviderHomeView(),
    // ),
    // GetPage(
    //   name: providerHomeLayout,
    //   page: () =>  ProviderHomeLayout(),
    // ),
    GetPage(
      name: adminHomeLayout,
      page: () => const AdminHomeLayout(),
    ),
    GetPage(
      name: manageCategory,
      page: () => const ManageCategoriesView(),
    ),
    GetPage(
      name: manageLocations,
      page: () => const ManageLocationView(),
    ),
    GetPage(
      name: manageProviderTypes,
      page: () => const ManageProviderTypesView(),
    ),
    GetPage(
      name: seeAllCategories,
      page: () => const SeeAllCategories(),
    ),

    // service request
    GetPage(
      name: addServicesRequest,
      page: () => AddServiceRequest(),
    ),
    GetPage(
      name: getRequestServices,
      page: () => GetUserServiceRequest(),
    ),
    GetPage(
      name: serviceRequestDetails,
      page: () => ServiceRequestDetails(),
    ),

    // service details
    GetPage(
      name: serviceDetails,
      page: () => ServiceDetailsView(),
    ),
    GetPage(
      name: providersInCategory,
      page: () => ProvidersInCategories(),
    ),

    // provider
    GetPage(
      name: providerProfile,
      page: () => const ProviderProfileView(),
    ),
    GetPage(
      name: providerPreviousWork,
      page: () => const PreviousWorkView(),
    ),

    // Shop
    GetPage(
      name: shop,
      page: () => const ShopView(),
    ),
    GetPage(
      name: shopProductDetails,
      page: () => const ShopProductDetailsView(),
    ),
    GetPage(
      name: shopCart,
      page: () => const ShopCartView(),
    ),
    GetPage(
      name: shopAddNewProduct,
      page: () => const ShopAddNewProductView(),
    ),
    GetPage(
      name: shopEditProduct,
      page: () => const ShopEditProductView(),
    ),
    GetPage(
      name: shopAddNewCategory,
      page: () => const ShopAddNewCategoryView(),
    ),
    GetPage(
      name: shopEditCategory,
      page: () => const ShopEditCategoryView(),
    ),

    // Edit Client Profile
    GetPage(
      name: editClientProfile,
      page: () => const EditClientProfileView(),
    ),

    // Change Password
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordView(),
    ),

    // Complaints
    GetPage(
      name: complaints,
      page: () => const ComplaintsView(),
    ),

    // Notification
    GetPage(
      name: notification,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: search,
      page: () => SearchView(),
    ),

    // Order
    GetPage(
      name: shopOrders,
      page: () => const OrdersView(),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetailsView(),
    ),
    GetPage(
      name: orderItem,
      page: () => const OrderItemView(),
    ),

    // Edit Provider Profile
    GetPage(
      name: editProviderProfile,
      page: () => const EditProviderProfileView(),
    ),
    GetPage(
      name: addProviderService,
      page: () => const AddProviderServiceView(),
    ),
    GetPage(
      name: editProviderService,
      page: () => const EditProviderServiceView(),
    ),

    GetPage(
      name: providerContacts,
      page: () => const ProviderContactsView(),
    ),
  ];
}
