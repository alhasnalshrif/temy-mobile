import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/helpers/spacing.dart';

class MaintenanceScreen extends StatefulWidget {
  final String? message;
  final String? logo;
  final String? phone;
  final String? about;
  final String? address;
  final Future<void> Function()? onRefresh;

  const MaintenanceScreen({
    super.key,
    this.message,
    this.logo,
    this.phone,
    this.about,
    this.address,
    this.onRefresh,
  });

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    if (widget.onRefresh == null || _isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await widget.onRefresh!();
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

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
                widget.message ??
                    'We are currently performing scheduled maintenance to improve our services. Please check back later.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainBlue,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(20),

              if (widget.about != null && widget.about!.isNotEmpty) ...[
                Text(
                  widget.about!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
              ],

              // Contact Info (Phone)
              if (widget.phone != null && widget.phone!.isNotEmpty) ...[
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
                        widget.phone!,
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

              if (widget.address != null && widget.address!.isNotEmpty) ...[
                verticalSpace(20),
                Text(
                  widget.address!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
              ],

              // Refresh Button
              if (widget.onRefresh != null) ...[
                verticalSpace(40),
                GestureDetector(
                  onTap: _handleRefresh,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isRefreshing ? Colors.grey[300] : ColorsManager.mainBlue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isRefreshing)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else
                          const Icon(
                            Icons.refresh,
                            size: 18,
                            color: Colors.white,
                          ),
                        horizontalSpace(8),
                        Text(
                          _isRefreshing ? 'Refreshing...' : 'Refresh',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
