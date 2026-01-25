// ignore_for_file: constant_identifier_names

class AppRoutes {
  // Auth Routes
  static const String Login = '/login';
  static const String Signup = '/signup';
  static const String Verification = '/verification';
  static const String ForgotPassword = '/forgot-password';
  static const String ResetPassword = '/reset-password';

  // Main App Routes
  static const String Dashboard = '/dashboard';
  static const String Home = '/home';
  static const String Booking = '/booking';
  static const String Profile = '/profile';
  static const String Categories = '/categories';
  static const String Category = '/category';
  static const String CategoryBarbers = '/category/:categoryId';

  // Barber & Services
  static const String Barber = '/barber';
  static const String BarberDetail = '/barber/:barberId';

  // Booking & Reservations
  static const String Reservation = '/reservation';
  static const String BookingConfirmation = '/booking-confirmation';
  static const String Invoice = '/invoice';

  // Profile Routes
  static const String UpdateProfile = '/profile/update';
  static const String NotificationSettings = '/profile/notification-settings';
  static const String PrivacyPolicy = '/profile/privacy-policy';
  static const String Help = '/profile/help';
  static const String About = '/profile/about';

  // Route names (for named navigation)
  static const String loginName = 'login';
  static const String signupName = 'signup';
  static const String verificationName = 'verification';
  static const String forgotPasswordName = 'forgotPassword';
  static const String resetPasswordName = 'resetPassword';
  static const String dashboardName = 'dashboard';
  static const String homeName = 'home';
  static const String bookingName = 'booking';
  static const String profileName = 'profile';
  static const String categoriesName = 'categories';
  static const String categoryBarbersName = 'categoryBarbers';
  static const String barberName = 'barber';
  static const String reservationName = 'reservation';
  static const String bookingConfirmationName = 'bookingConfirmation';
  static const String invoiceName = 'invoice';
  static const String updateProfileName = 'updateProfile';
  static const String notificationSettingsName = 'notificationSettings';
  static const String privacyPolicyName = 'privacyPolicy';
  static const String helpName = 'help';
  static const String aboutName = 'about';

  /// Helper methods for dynamic routes with parameters
  ///
  /// Example usage:
  /// AppRoutes.barberPath('123') // Returns '/barber/123'
  /// AppRoutes.categoryPath('456') // Returns '/category/456'

  static String barberPath(String barberId) => '$Barber/$barberId';
  static String categoryPath(String categoryId) => '$Category/$categoryId';
}
