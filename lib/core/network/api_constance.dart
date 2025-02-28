import '/core/constants/app_constants.dart';

class ApiConstance {
  static const String baseUrl = 'https://tiqnia.com/Apps/b2b_partenership/api/';

  static String token = '';

  // global
  static String countries = 'countries';
  static String cities = 'governments';
  static String getProviderTypes = 'provider-types';
  static String getSpecialization = 'specializations';
  static String getSupSpecialization = 'sub-specializations';

  /// Auth
  static const String login = 'auth/login';
  static const String logout = 'patient/auth/logout';
  static const String register = 'auth/register';
  static const String checkEmail = 'patient/auth/check-email';
  static const String checkPhone = 'patient/auth/check-phone';
  static const String registerWithGoogle = 'patient/auth/register-with-google';
  static const String loginWithGoogle = 'patient/auth/login-with-google';
  static const String profile = 'patient/profile';
  static final String updateProfile = 'patient/$kUserId';
  static const String resetPassword = 'auth/reset-password';
  static const String forgetPassword = 'auth/forget-password';
  static const String sendOTP = 'send-otp';
  static const String verifyOTP = 'verify-otp';
  static const String deleteAccount = 'auth/delete-account';

  //client
  static String getClientMenu(String id) => '/clients/$id';

  // home
  static const String getBanners = 'banners';
  static const String getTopServices = 'home/top-services';
  static const String getTopProviders = 'home/top-providers';
  static const String getNewServices = 'home/new-services';
  static const String getJobs = 'home/new-jobs';
  static const String search = 'specializations/providers';

  // service request
  static const String addServiceRequest = 'request-services';
  static String getClientServiceRequest(String id) => 'clients/$id/services';
  static const String getServicePriceOffer = 'request-offers';
  static String acceptPriceOffers(String id) =>
      'request-offers/$id/accept-offer';
  static const String addPriceOffer = 'request-offers';
  static const String getProviderOffersInPost = 'provider-offers';
  static String deletePriceOffer(String id) => 'request-offers/$id';

  //service details
  static String getServiceDetails(String id) => 'provider-service/$id';
  static const String getReviewServices = 'provider-service-reviews';
  static const String getFeatureServices = 'provider-service-features';
  static const String getAllPendingServices = 'request-services';

  //provider
  static String getProviderProfileDetails(String id) => 'providers/$id';
  static String getProviderServices(String id) => 'providers/$id/services';
  static String getProviderMenu(String id) => 'providers/$id';
  static String getServicesInCategory(String id) =>
      'specializations/$id/services';
  static String getProvidersInCategory = 'specializations/providers';
  static String getProviderPerviousWork = 'provider-previous-works';
  static String getTopCountriesProv(String id) =>
      'home/country/$id/top-providers';
  static String getWorkImages = '/previous-work-images';
  static String addReview = '/provider-service-reviews';
  static String addNewService = '/provider-service';
  static String addProviderService = "provider-service";
  static String updateProviderService(String id) =>
      "provider-service/$id/update";

  // favorite
  static String getUserFavorite = 'favorite-providers';
  static String toggleFavorite = 'toggle-favorite';

  // shop app

  static String shopCategories = 'store/categories';
  static String shopProducts = 'store/products';
  static String shopCart = "store/carts";
  static String deleteCartItem(int id) => "store/carts/$id";
  static String clearCart = "store/cart/clear";
  static String addToCart = "store/carts";
  static String checkout = "store/orders";
  static String getOrders = 'store/orders';
  static String getOrderDetails(String id) => 'store/orders/$id';

  // Client Profile
  static String updateClientProfile(String id) => 'clients/$id/update';

  // Complaints
  static String addComplaint = 'complaints';
  static String getComplaints = 'complaints';

  // Notifications
  static String getNotifications = 'notifications';

  static String updateProviderProfile(String id) => "providers/$id/update";

  static String deleteProviderService(String id) => "provider-service/$id";

  // provider-service-features
  static const String addProviderServiceFeatures = "provider-service-features";
  static String deleteProviderServiceFeature(String id) =>
      "provider-service-features/$id";

  static String getProviderContacts(String providerId) =>
      "provider/$providerId/contacts";
  static const String addOrUpdateProviderContacts = "provider-contacts";
}
