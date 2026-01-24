import 'package:temy_barber/core/helpers/constants.dart';

/// Helper class for handling profile authentication checks
class ProfileAuthHelper {
  ProfileAuthHelper._();

  /// Check if user is logged in using global authentication state
  static bool isUserLoggedIn() {
    return isLoggedInUser;
  }

  /// Check if user is a guest (not logged in)
  static bool isGuest() {
    return !isLoggedInUser;
  }
}
