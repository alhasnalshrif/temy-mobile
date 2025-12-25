# Google Play SDK Compliance - Quick Answers

This document provides direct answers to Google Play's User Data Policy questions.

---

## Question 1: What SDKs does your app use and why?

Our Temy Barber app uses the following third-party SDKs:

**Push Notifications:**
- **OneSignal Flutter SDK (v5.1.1)** - For sending push notifications to users about appointments, promotions, and updates

**Error Monitoring:**
- **Sentry Flutter SDK (v8.0.0)** - For crash reporting and error tracking to improve app stability and performance

**Networking:**
- **Dio (v5.3.3)** - HTTP client for API communication with our backend
- **Retrofit (v4.0.3)** - Type-safe REST API client generation

**State Management:**
- **Flutter BLoC (v8.1.6)** - For predictable state management
- **GetIt (v7.7.0)** - Dependency injection container

**UI/UX:**
- **Cached Network Image (v3.3.1)** - Image loading and caching
- **Flutter SVG (v2.0.9)** - SVG rendering
- **Shimmer (v3.0.0)** - Loading animations
- **Carousel Slider (v5.0.0)** - Image galleries

**Localization:**
- **Easy Localization (v3.0.7)** - Multi-language support for Arabic and English

**Storage:**
- **Flutter Secure Storage (v9.2.4)** - Encrypted storage for sensitive data
- **Shared Preferences (v2.5.3)** - User preferences storage

**Document Handling:**
- **PDF (v3.10.4)** - PDF generation for invoices
- **Path Provider (v2.1.1)** - File system access
- **Share Plus (v11.1.0)** - Native sharing functionality

**Code Generation (Dev Tools):**
- **Freezed (v3.2.3)** - Data class generation
- **JSON Serializable (v6.9.0)** - JSON serialization

---

## Question 2: Explain how you ensure that any 3rd party code and SDKs used in your app comply with our policies.

We ensure third-party SDK compliance through the following measures:

**1. SDK Selection Process:**
- Only use SDKs from verified publishers with proven track records
- Prefer open-source packages where code can be audited
- Check pub.dev ratings, popularity, and maintenance status
- Review each SDK's documentation and privacy practices before integration

**2. Privacy & Data Collection Verification:**
- Only 2 of our 19 SDKs collect any user data (OneSignal for push notifications, Sentry for error tracking)
- Both SDKs are GDPR compliant and SOC 2 Type II certified:
  - **OneSignal**: https://onesignal.com/privacy_policy (GDPR, CCPA, ISO 27001 certified)
  - **Sentry**: https://sentry.io/privacy/ (GDPR, SOC 2 Type II, Privacy Shield certified)
- All other SDKs operate locally without external data transmission
- We follow data minimization - only collect data necessary for functionality

**3. Security Measures:**
- All SDKs are version-pinned to prevent unexpected updates
- Regular monitoring of security advisories on pub.dev
- HTTPS-only communication for all network requests
- Sensitive data encrypted using platform-native secure storage
- No advertising or tracking SDKs that collect unnecessary user data

**4. Compliance Verification:**
- Review privacy policies and terms of service for all SDKs that handle user data
- Data Processing Agreements in place with OneSignal and Sentry (GDPR requirement)
- All SDK licenses verified as compatible with commercial use
- Regular quarterly reviews of all dependencies for continued compliance

**5. User Control & Transparency:**
- Users can opt-out of push notifications
- Clear privacy policy disclosing all third-party services
- Minimal permission requests (only what's necessary)
- Runtime permission requests with clear explanations

**6. Maintenance & Updates:**
- Security patches applied within 30 days
- Regular SDK version updates for bug fixes and improvements
- Dependency tree audited to ensure transitive dependencies are compliant
- Documentation maintained for all SDK changes

Our approach prioritizes user privacy, data minimization, and transparency while ensuring all third-party code meets Google Play's policy requirements and industry security standards.
