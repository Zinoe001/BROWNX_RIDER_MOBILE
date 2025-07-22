class ApiRoute {
  /// Base Url
  static const String baseUrl = "https://brownx-sgz6.onrender.com";

  ///Refresh Url
  static const String refreshToken = "$baseUrl/dispatches/refresh";

  ///Location Url
  static const String location = "$baseUrl/users/location";

  /// Auth Url
  static const String otpVerification =
      "$baseUrl/dispatches/verification-code/verification";
  static const String signUp = "$baseUrl/dispatches/register";
  static const String login = "$baseUrl/dispatches/login";
  static const String forgotPassword = "$baseUrl/dispatches/forgot-password";
  static const String forgotPasswordVerification =
      "$baseUrl/dispatches/verification-code/password/reset";
  static const String resetPassword = "$baseUrl/dispatches/reset-password";
  static const String resendCode = "$baseUrl/dispatches/resend-code";
  // static const String googleLogin = "/customers/auth/google/login";

  /// Profile Url
  static const String updateProfile = "/dispatches/profile";
  static const String changePassword = "/dispatches/password";
  static const String passwordResetverification = "/dispatches/password/reset";
  static const String disableAccount = "/users/disable-account";
  static String favourite(String id) =>
      "/dispatches/favourites/deliveries?page=$id";

  /// Transaction Url
  static const String getWallet = "/users/wallet";
  static const String verifyTransaction = "/users/payment/callback";
  static String fundWallet(String id) => "/users/wallets/$id";
  static String payRider(String id) => "dispatches/paymets/$id";
  static String getTransactions(String id) => "/users/transactions?page=$id";

  /// Delivery Url
  static const String getDispatch = "/dispatches/dispatches";
  static const String changeStatus = "/dispatches/status";
  static const String uploadDeliveryDetails = "/dispatches/deliveries";
  static String deliveryHistory(String id) =>
      "/dispatches/history/deliveries?page=$id";
  static String comment(String id) => "/dispatches/comments/$id";
  static String getDeliveries(String id) =>
      "/dispatches/bookings/lists/pending?page=$id";

  /// Notification Base Url
  static const String notificationbaseUrl =
      "https://api.onesignal.com/notifications";
}
