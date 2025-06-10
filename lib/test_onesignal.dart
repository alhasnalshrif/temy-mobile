import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'core/config/notification_config.dart';
import 'core/services/notification_service.dart';
import 'core/di/dependency_injection.dart';

/// Test script to validate OneSignal configuration
Future<void> testOneSignalConfiguration() async {
  log('🧪 Testing OneSignal Configuration...');
  
  // 1. Check configuration
  log('📋 Configuration Status:');
  log('   App ID: ${NotificationConfig.oneSignalAppId}');
  log('   Is Configured: ${NotificationConfig.isConfigured}');
  log('   Debug Logging: ${NotificationConfig.enableDebugLogging}');
  
  if (!NotificationConfig.isConfigured) {
    log('❌ OneSignal is not configured properly');
    log('   Update the App ID in lib/core/config/notification_config.dart');
    return;
  }
  
  try {
    // 2. Test initialization
    log('🚀 Testing OneSignal initialization...');
    final service = getIt<NotificationService>();
    await service.initialize();
    
    // 3. Test status
    log('📊 Testing OneSignal status...');
    final status = await service.testOneSignalStatus();
    
    log('✅ OneSignal Test Results:');
    status.forEach((key, value) {
      log('   $key: $value');
    });
    
  } catch (e) {
    log('❌ OneSignal test failed: $e');
  }
}

void main() async {
  // Initialize dependencies
  setupGetIt();
  
  // Run test
  await testOneSignalConfiguration();
}
