import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';

/// Service to handle JWT token validation and authentication state
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  /// Check if user is authenticated with a valid token
  Future<bool> isAuthenticated() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    
    if (token == null || token.isEmpty) {
      debugPrint('🔐 AuthService: No token found');
      return false;
    }

    // Validate token structure and expiration
    final isValid = await validateToken(token);
    
    if (!isValid) {
      debugPrint('🔐 AuthService: Token is invalid or expired');
      await clearAuthentication();
      return false;
    }

    debugPrint('✅ AuthService: Token is valid');
    return true;
  }

  /// Validate JWT token structure and expiration
  Future<bool> validateToken(String token) async {
    try {
      // Split JWT token (format: header.payload.signature)
      final parts = token.split('.');
      
      if (parts.length != 3) {
        debugPrint('❌ AuthService: Invalid token format');
        return false;
      }

      // Decode payload (second part)
      final payload = parts[1];
      
      // Add padding if needed for base64 decoding
      String normalizedPayload = base64Url.normalize(payload);
      
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedPayload = utf8.decode(decodedBytes);
      final Map<String, dynamic> payloadMap = json.decode(decodedPayload);

      debugPrint('🔍 AuthService: Token payload decoded');
      
      // Check if token has expiration
      if (payloadMap.containsKey('exp')) {
        final exp = payloadMap['exp'];
        final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        final now = DateTime.now();

        debugPrint('🕐 AuthService: Token expires at: $expirationDate');
        debugPrint('🕐 AuthService: Current time: $now');

        if (now.isAfter(expirationDate)) {
          debugPrint('❌ AuthService: Token has expired');
          return false;
        }

        // Check if token is about to expire (within 1 hour)
        final timeUntilExpiry = expirationDate.difference(now);
        if (timeUntilExpiry.inHours < 1) {
          debugPrint('⚠️ AuthService: Token expires soon (${timeUntilExpiry.inMinutes} minutes)');
          // TODO: Implement token refresh if backend supports it
        }
      }

      // Validate user ID exists in token
      if (payloadMap.containsKey('userId') || payloadMap.containsKey('id') || payloadMap.containsKey('sub')) {
        final userId = payloadMap['userId'] ?? payloadMap['id'] ?? payloadMap['sub'];
        debugPrint('✅ AuthService: Token contains user ID: $userId');
        
        // Store/update user ID if not already stored
        final storedUserId = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
        if (storedUserId == null || storedUserId.isEmpty) {
          await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, userId.toString());
        }
      }

      return true;
    } catch (e) {
      debugPrint('❌ AuthService: Error validating token: $e');
      return false;
    }
  }

  /// Get user ID from token
  Future<String?> getUserIdFromToken() async {
    try {
      final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
      
      if (token == null || token.isEmpty) {
        return null;
      }

      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      String normalizedPayload = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalizedPayload);
      final decodedPayload = utf8.decode(decodedBytes);
      final Map<String, dynamic> payloadMap = json.decode(decodedPayload);

      return payloadMap['userId']?.toString() ?? 
             payloadMap['id']?.toString() ?? 
             payloadMap['sub']?.toString();
    } catch (e) {
      debugPrint('❌ AuthService: Error getting user ID from token: $e');
      return null;
    }
  }

  /// Clear all authentication data
  Future<void> clearAuthentication() async {
    debugPrint('🗑️ AuthService: Clearing authentication data');
    
    // Clear token from headers
    DioFactory.clearTokenFromHeader();
    
    // Clear stored credentials
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.clearAllData();
    
    // Update global state
    isLoggedInUser = false;
    
    debugPrint('✅ AuthService: Authentication cleared');
  }

  /// Save authentication token
  Future<void> saveToken(String token, {String? userId}) async {
    debugPrint('💾 AuthService: Saving authentication token');
    
    // Save token
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    
    // Save user ID if provided, otherwise extract from token
    if (userId != null && userId.isNotEmpty) {
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, userId);
    } else {
      final extractedUserId = await getUserIdFromToken();
      if (extractedUserId != null) {
        await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, extractedUserId);
      }
    }
    
    // Update Dio headers
    DioFactory.setTokenIntoHeaderAfterLogin(token);
    
    // Update global state
    isLoggedInUser = true;
    
    debugPrint('✅ AuthService: Token saved successfully');
  }

  /// Get stored token
  Future<String?> getToken() async {
    return await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  }

  /// Get stored user ID
  Future<String?> getUserId() async {
    return await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
  }
}
