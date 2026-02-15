import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/helpers/spacing.dart';

class MaintenanceScreen extends StatelessWidget {
  final String? message;
  final String? logo;
  final String? phone;
  final String? about;
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.6,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.build_rounded,
                  size: 80,
                  color: ColorsManager.mainBlue,
                ),
              ),
              verticalSpace(30),
              // Message
              Text(
                message ??
                    'We are currently performing scheduled maintenance to improve our services. Please check back later.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainBlue,
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
