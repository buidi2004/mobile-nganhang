class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const String wsUrl = 'ws://localhost:8080/ws-native';
  static const String wsTopicPrefix = '/topic/users';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String otpVerify = '/auth/otp/verify';
  static const String otpSend = '/auth/otp/send';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String logout = '/auth/logout';
  static const String setPin = '/users/pin/set';
  static const String verifyPin = '/users/pin/verify';
  static const String biometricVerify = '/security/biometric/verify';

  // Wallet & Transfer endpoints
  static String walletDetail(String walletId) => '/wallets/$walletId';
  static const String recipientInfo = '/wallets/recipient-info';
  static const String estimateFee = '/wallets/fees/estimate';
  static const String transferInit = '/wallets/transfer/init';
  static String transferConfirm(String id) => '/wallets/transfer/$id/confirm';
  static const String deposit = '/wallets/deposit';
  static const String withdraw = '/wallets/withdraw';

  // Transactions & Statement
  static const String transactions = '/transactions';
  static String transactionDetail(String id) => '/transactions/$id';
  static String receiptPdf(String id) => '/transactions/$id/receipt.pdf';
  static String exportTransactions(String format) => '/transactions/export/$format';

  // QR Code
  static const String decodeVietQr = '/payments/vietqr/decode';
  static const String generateVietQr = '/payments/vietqr/generate';
  static const String myQrCode = '/users/me/qrcode';

  // Bills & Utilities
  static const String billLookup = '/bills/lookup';
  static const String billPay = '/bills/pay';
  static const String billTopup = '/bills/topup';

  // Sources & Banks
  static const String banks = '/banks';
  static const String beneficiaries = '/beneficiaries';
  static const String fundingSources = '/funding-sources';
  static const String bankAccounts = '/bank-accounts';

  // User Profile & KYC
  static const String userMe = '/users/me';
  static const String userAvatar = '/users/me/avatar';
  static const String kycSubmit = '/users/kyc';
  static const String kycStatus = '/users/kyc/status';
  static const String limitStatus = '/config/limits/status';

  // Sessions & Notifications
  static const String sessions = '/sessions';
  static String sessionDetail(String deviceId) => '/sessions/$deviceId';
  static String sessionFcm(String deviceId) => '/sessions/$deviceId/fcm';
  static const String notifications = '/notifications';
  static String readNotification(String id) => '/notifications/$id/read';
  static const String readAllNotifications = '/notifications/read-all';
  static const String faq = '/support/faq';
  static const String tickets = '/support/tickets';
}
