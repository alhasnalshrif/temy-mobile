import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:temy_barber/core/theme/colors.dart';

class UpdateModal extends StatelessWidget {
  final bool forceUpdate;
  final String androidUrl;
  final String iphoneUrl;

  const UpdateModal({
    super.key,
    required this.forceUpdate,
    required this.androidUrl,
    required this.iphoneUrl,
  });

  static void show(
    BuildContext context, {
    required bool forceUpdate,
    required String androidUrl,
    required String iphoneUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: !forceUpdate,
      enableDrag: !forceUpdate,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async => !forceUpdate,
        child: UpdateModal(
          forceUpdate: forceUpdate,
          androidUrl: androidUrl,
          iphoneUrl: iphoneUrl,
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final urlString = Platform.isIOS ? iphoneUrl : androidUrl;
    if (urlString.isEmpty) return;

    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(
            Icons.system_update_rounded,
            size: 64,
            color: ColorsManager.mainBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'update_required.title'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'update_required.message'.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _launchUrl,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'update_required.button'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (!forceUpdate) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'update_required.skip'.tr(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
