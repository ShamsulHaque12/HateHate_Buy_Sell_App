class ApiUrls {
  ApiUrls._();

  static const String baseUrl = 'https://api.example.com/api/v1';

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';
  static const String refreshToken = '$baseUrl/auth/refresh-token';

  // Home endpoints
  static const String home = '$baseUrl/home';

  // Category endpoints
  static const String categories = '$baseUrl/categories';

  // Search & Filter endpoints
  static const String search = '$baseUrl/search';

  // Chat endpoints
  static const String chats = '$baseUrl/chats';

  // Favorites endpoints
  static const String favorites = '$baseUrl/favorites';

  // Profile endpoints
  static const String profile = '$baseUrl/profile';

  // Notification endpoints
  static const String notifications = '$baseUrl/notifications';

  // Report endpoints
  static const String reports = '$baseUrl/reports';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
