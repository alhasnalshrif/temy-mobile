import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
// import 'package:temy_barber/core/widgets/app_text_button.dart'; // Removed as I want to keep it simple and avoid potential issues

class MaintenanceScreen extends StatelessWidget {
  final String? message;
  final String? logo;
  final String? phone;
  final String? about; // Added about
  final String? address;

  const MaintenanceScreen({
    super.key,
    this.message,
    this.logo,
    this.phone,
    this.about,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              if (logo != null && logo!.isNotEmpty) ...[
                Image.network(
                  logo!,
                  height: 120,
                  width: 120,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.build_rounded,
                    size: 80,
                    color: ColorsManager.mainBlue,
                  ),
                ),
                verticalSpace(30),
              ] else ...[
                const Icon(
                  Icons.build_rounded,
                  size: 80,
                  color: ColorsManager.mainBlue,
                ),
                verticalSpace(30),
              ],

              // Title
              const Text(
                'Under Maintenance',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(16),

              // Message
              Text(
                message ??
                    'We are currently performing scheduled maintenance to improve our services. Please check back later.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(20),

              if (about != null && about!.isNotEmpty) ...[
                Text(
                  about!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
              ],

              // Contact Info (Phone)
              if (phone != null && phone!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 20,
                        color: ColorsManager.mainBlue,
                      ),
                      horizontalSpace(8),
                      Text(
                        phone!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (address != null && address!.isNotEmpty) ...[
                verticalSpace(20),
                Text(
                  address!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
