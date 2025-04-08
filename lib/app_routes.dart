import 'package:b2b_partnership_admin/views/jobs/jobs_view.dart';
import 'package:b2b_partnership_admin/views/manage_categories/manage_categories_view.dart';
import 'package:b2b_partnership_admin/views/manage_users/client_profile_view.dart';
import 'package:b2b_partnership_admin/views/manage_users/manage_admins_view.dart';
import 'package:b2b_partnership_admin/views/manage_users/manage_clients_view.dart';
import 'package:b2b_partnership_admin/views/manage_location/manage_location_view.dart';
import 'package:b2b_partnership_admin/views/manage_provider_types/manage_provider_types_view.dart';
import 'package:b2b_partnership_admin/views/manage_users/manage_provider_view.dart';
import 'package:b2b_partnership_admin/views/manage_users/provider_profile/paper_pdf_view.dart';
import 'package:b2b_partnership_admin/views/shop/products/shop_add_new_product_view.dart';
import 'package:b2b_partnership_admin/views/shop/products/shop_product_details_view.dart';

import '/views/auth/forget_password_email_view.dart';
import '/views/auth/forget_password_reset_view.dart';
import '/views/auth/login_view.dart';
import '/views/auth/o_t_p_view.dart';
import 'views/complaints/complaints_users_view.dart';
import 'views/home/admin_home_layout.dart';
import '/views/orders/orders_view.dart';

import 'views/jobs/job_details_view.dart';
import 'views/manage_users/provider_profile/previous_work_view.dart';
import 'views/manage_users/provider_profile/provider_profile_view.dart';
import '/views/service_details_view.dart';
import '/views/service_request/add_service_request.dart';
import '/views/service_request/get_user_service_request.dart';
import '/views/settings/change_password_view.dart';
import 'views/posts/clients_service_request_view.dart';
import 'views/settings/edit_admin_profile_view.dart';
import '/views/shop/shop_cart_view.dart';
import '/views/shop/shop_view.dart';
import '/views/splash/views/splash_view.dart';
import 'package:get/get.dart';

import 'views/complaints/complaints_view.dart';
import 'views/notifications/views/notification_view.dart';
import 'views/orders/order_details_view.dart';
import 'views/orders/order_item_view.dart';

import 'views/service_request/service_request_details.dart';
import 'views/shop/categories/shop_add_new_category_view.dart';
import 'views/shop/categories/shop_edit_category_view.dart';
import 'views/shop/products/shop_edit_product_view.dart';

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

  //admin -----> manage home
  static const String manageCategory = '/manageCategory';
  static const String manageProviderTypes = '/manageProviderTypes';
  static const String manageLocations = '/manageLocations';

  //admin -----> manage users
  static const String manageClients = '/manageClients';
  static const String manageProviders = '/manageProviders';
  static const String pdfView = '/pdfView';
  static const String manageAdmins = '/manageAdmins';
  static const String clientProfileView = '/clientProfileView';

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
  static const String editAdminProfile = '/editClientProfile';
  static const String changePassword = '/changePassword';

  // Complaints
  static const String complaints = '/complaints';
  static const String complaintsUsers = '/complaintsUsers';

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

  static const String clientsService = '/clientsService';
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobDetails';

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
      name: manageClients,
      page: () => const ManageClientsView(),
    ),

    GetPage(
      name: clientProfileView,
      page: () => const ClientProfileView(),
    ),

    GetPage(
      name: manageProviders,
      page: () => const ManageProviderView(),
    ),
    GetPage(
      name: pdfView,
      page: () => const PaperPdfView(),
    ),
    GetPage(
      name: manageAdmins,
      page: () => const ManageAdminsView(),
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
      page: () =>  ShopAddNewProductView(),
    ),
    GetPage(
      name: shopEditProduct,
      page: () => ShopEditProductView(),
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
      name: editAdminProfile,
      page: () => const EditAdminProfileView(),
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
    GetPage(
      name: complaintsUsers,
      page: () => const ComplaintsUsersView(),
    ),

    // Notification
    GetPage(
      name: notification,
      page: () => const NotificationView(),
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

    // Settings
    GetPage(
      name: clientsService,
      page: () => ClientsServiceRequestView(),
    ),
    GetPage(
      name: jobs,
      page: () => JobsView(),
    ),
    GetPage(
      name: jobDetails,
      page: () => const JobDetailsView(),
    ),

    // Edit Provider Profile
    // GetPage(
    //   name: editProviderProfile,
    //   page: () => const EditProviderProfileView(),
    // ),
    // GetPage(
    //   name: addProviderService,
    //   page: () => const AddProviderServiceView(),
    // ),
    // GetPage(
    //   name: editProviderService,
    //   page: () => const EditProviderServiceView(),
    // ),

    // GetPage(
    //   name: providerContacts,
    //   page: () => const ProviderContactsView(),
    // ),
  ];
}
