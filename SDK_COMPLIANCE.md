# SDK Compliance Documentation for Google Play

This document provides answers to Google Play's User Data Policy requirements regarding third-party SDKs and compliance verification.

## 1. What SDKs does your app use and why?

Our Temy Barber mobile application uses the following third-party SDKs and libraries:

### State Management & Architecture
- **flutter_bloc (v8.1.6)**
  - **Purpose**: State management solution for predictable state container
  - **Data Collection**: None - local state management only
  - **Publisher**: Felix Angelov / BLoC Library
  - **Privacy Policy**: https://pub.dev/packages/flutter_bloc

- **get_it (v7.7.0)**
  - **Purpose**: Dependency injection container for service locator pattern
  - **Data Collection**: None - local dependency management only
  - **Publisher**: Thomas Burkhart
  - **Privacy Policy**: https://pub.dev/packages/get_it

### Networking & API Communication
- **dio (v5.3.3)**
  - **Purpose**: HTTP client for making API requests to backend services
  - **Data Collection**: None - networking library only, no analytics
  - **Publisher**: Alibaba
  - **Privacy Policy**: https://pub.dev/packages/dio

- **retrofit (v4.0.3)**
  - **Purpose**: Type-safe HTTP client generator for REST API integration
  - **Data Collection**: None - code generation tool for API calls
  - **Publisher**: Trevor Wang
  - **Privacy Policy**: https://pub.dev/packages/retrofit

- **pretty_dio_logger (v1.3.1)**
  - **Purpose**: Development tool for logging HTTP requests/responses (debug only)
  - **Data Collection**: None - local logging only
  - **Publisher**: hunghd
  - **Privacy Policy**: https://pub.dev/packages/pretty_dio_logger

### Push Notifications
- **onesignal_flutter (v5.1.1)**
  - **Purpose**: Push notification delivery to engage users with timely updates
  - **Data Collection**: Device identifiers, notification interactions, app usage data
  - **Publisher**: OneSignal Inc.
  - **Privacy Policy**: https://onesignal.com/privacy_policy
  - **Compliance**: GDPR and CCPA compliant, SOC 2 Type II certified

### Error Tracking & Monitoring
- **sentry_flutter (v8.0.0)**
  - **Purpose**: Error tracking and performance monitoring to improve app stability
  - **Data Collection**: Error logs, stack traces, device info, performance metrics
  - **Publisher**: Sentry
  - **Privacy Policy**: https://sentry.io/privacy/
  - **Compliance**: GDPR compliant, SOC 2 Type II certified, data anonymization available

### Localization & Internationalization
- **easy_localization (v3.0.7)**
  - **Purpose**: Internationalization and localization support for multiple languages
  - **Data Collection**: None - local translation management only
  - **Publisher**: Aissat
  - **Privacy Policy**: https://pub.dev/packages/easy_localization

- **intl (v0.20.2)**
  - **Purpose**: Internationalization utilities and date/time formatting
  - **Data Collection**: None - local formatting utilities only
  - **Publisher**: Dart Team
  - **Privacy Policy**: https://pub.dev/packages/intl

### UI Components & Enhancement
- **flutter_svg (v2.0.9)**
  - **Purpose**: SVG rendering for vector graphics support
  - **Data Collection**: None - local rendering only
  - **Publisher**: Dan Field
  - **Privacy Policy**: https://pub.dev/packages/flutter_svg

- **cached_network_image (v3.3.1)**
  - **Purpose**: Image caching for improved performance and offline support
  - **Data Collection**: None - local image caching only
  - **Publisher**: Baseflow
  - **Privacy Policy**: https://pub.dev/packages/cached_network_image

- **shimmer (v3.0.0)**
  - **Purpose**: Loading placeholders with shimmer effect for better UX
  - **Data Collection**: None - UI effect only
  - **Publisher**: Hung HD
  - **Privacy Policy**: https://pub.dev/packages/shimmer

- **carousel_slider (v5.0.0)**
  - **Purpose**: Image carousel widget for displaying multiple items
  - **Data Collection**: None - UI component only
  - **Publisher**: serenader2014
  - **Privacy Policy**: https://pub.dev/packages/carousel_slider

- **flutter_native_splash (v2.3.5)**
  - **Purpose**: Native splash screen generation for iOS and Android
  - **Data Collection**: None - build-time asset generation only
  - **Publisher**: Jon Hanson
  - **Privacy Policy**: https://pub.dev/packages/flutter_native_splash

### Data Storage & Persistence
- **flutter_secure_storage (v9.2.4)**
  - **Purpose**: Secure storage for sensitive data (tokens, credentials)
  - **Data Collection**: None - local encrypted storage only
  - **Publisher**: Mogol
  - **Privacy Policy**: https://pub.dev/packages/flutter_secure_storage

- **shared_preferences (v2.5.3)**
  - **Purpose**: Simple key-value storage for user preferences
  - **Data Collection**: None - local storage only
  - **Publisher**: Flutter Team
  - **Privacy Policy**: https://pub.dev/packages/shared_preferences

### Document Handling
- **pdf (v3.10.4)**
  - **Purpose**: PDF document generation for receipts and invoices
  - **Data Collection**: None - local PDF generation only
  - **Publisher**: David PHAM-VAN
  - **Privacy Policy**: https://pub.dev/packages/pdf

- **path_provider (v2.1.1)**
  - **Purpose**: Access to commonly used locations on the device filesystem
  - **Data Collection**: None - file system access only
  - **Publisher**: Flutter Team
  - **Privacy Policy**: https://pub.dev/packages/path_provider

- **share_plus (v11.1.0)**
  - **Purpose**: Sharing content to other apps via native share sheet
  - **Data Collection**: None - native share functionality only
  - **Publisher**: Flutter Community Plus
  - **Privacy Policy**: https://pub.dev/packages/share_plus

### Code Generation (Development Only)
- **freezed_annotation (v3.1.0)**
  - **Purpose**: Annotations for code generation (immutable data classes)
  - **Data Collection**: None - compile-time code generation only
  - **Privacy Policy**: https://pub.dev/packages/freezed_annotation

- **json_annotation (v4.9.0)**
  - **Purpose**: Annotations for JSON serialization code generation
  - **Data Collection**: None - compile-time code generation only
  - **Privacy Policy**: https://pub.dev/packages/json_annotation

## 2. How we ensure 3rd party code and SDKs comply with Google Play policies

We have implemented a comprehensive SDK compliance verification process:

### A. SDK Selection Criteria
1. **Reputation & Maintenance**: Only use SDKs from verified publishers with active maintenance and regular security updates
2. **Open Source Priority**: Prefer open-source SDKs where code can be audited (majority of our dependencies)
3. **Documentation Review**: Verify each SDK has clear documentation about data collection practices
4. **Community Vetting**: Use widely adopted SDKs with large communities (e.g., pub.dev popularity and likes)

### B. Privacy & Data Collection Verification
1. **Privacy Policy Review**: Each SDK with data collection capabilities has been verified to have a published privacy policy:
   - OneSignal: GDPR and CCPA compliant, SOC 2 Type II certified
   - Sentry: GDPR compliant, SOC 2 Type II certified, provides data anonymization

2. **Data Minimization**: We only use SDKs that collect data necessary for their specific function:
   - Push notifications (OneSignal): Device tokens and notification interactions only
   - Error tracking (Sentry): Error logs and performance data for debugging purposes only
   - No advertising SDKs or trackers that collect unnecessary user data

3. **Local-First Processing**: Most SDKs operate locally without external data transmission:
   - Storage, UI components, and utilities process data on-device only
   - Networking libraries (Dio, Retrofit) only connect to our own backend APIs

### C. Security & Compliance Measures
1. **Regular Updates**: Monitor and update SDK versions to patch security vulnerabilities
2. **Dependency Auditing**: Review dependency tree to ensure transitive dependencies are also compliant
3. **Secure Data Handling**:
   - Sensitive data stored using flutter_secure_storage with platform encryption
   - HTTPS-only communication through Dio for all network requests
   - No sensitive data sent to third-party analytics

4. **Certification Verification**:
   - OneSignal: SOC 2 Type II, GDPR compliant, ISO 27001 certified
   - Sentry: SOC 2 Type II, GDPR compliant, Privacy Shield certified

### D. Monitoring & Maintenance
1. **Version Pinning**: All SDK versions are explicitly defined in pubspec.yaml
2. **Security Alerts**: Monitor pub.dev security advisories for known vulnerabilities
3. **Regular Review**: Quarterly review of all third-party dependencies for compliance
4. **Update Policy**: Security patches applied within 30 days of disclosure

### E. Data Access & Permissions
1. **Minimal Permissions**: Only request Android/iOS permissions required by features in use
2. **Runtime Permissions**: All sensitive permissions requested at runtime with clear explanations
3. **User Consent**: Users can opt-out of optional features (push notifications) at any time
4. **Data Transparency**: Privacy policy clearly discloses all third-party services and their data practices

### F. Compliance Documentation
1. **License Compliance**: All SDKs use permissive licenses compatible with commercial use
2. **Terms of Service**: Each SDK's terms reviewed for policy compliance
3. **Data Processing Agreements**: DPA in place with OneSignal and Sentry where required by GDPR
4. **Documentation**: This document maintained and updated with any SDK changes

## Summary

Our app uses 19 third-party SDKs, with only 2 (OneSignal and Sentry) collecting any user data, both of which:
- Have clear, GDPR-compliant privacy policies
- Are SOC 2 Type II certified
- Provide enterprise-grade security and compliance
- Collect only data necessary for their specific functions (notifications and error monitoring)
- Allow for data anonymization and user opt-out

All other SDKs operate locally without external data transmission. We maintain a rigorous verification process to ensure ongoing compliance with Google Play Developer Program policies.

---

**Document Version**: 1.0  
**Last Updated**: December 2024  
**Next Review**: March 2025
