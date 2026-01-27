import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// ----------------- CONTENT SCREEN -----------------
/// Reusable screen that displays sections of content
class ContentScreen extends StatelessWidget {
  final String titleKey;
  final List<ContentSection> sections;

  const ContentScreen({
    super.key,
    required this.titleKey,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;
    final titleStyle = TextStyles.font14DarkBlueMedium.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final bodyStyle = TextStyles.font14DarkBlueMedium;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(titleKey.tr()),
        backgroundColor: ColorsManager.mainBlue,
        centerTitle: isLargeScreen,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: isLargeScreen ? 800 : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isLargeScreen ? 32 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections
                  .map(
                    (section) => _buildSection(
                      title: section.titleKey.tr(),
                      body: section.bodyKey.tr(),
                      titleStyle: titleStyle,
                      bodyStyle: bodyStyle,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String body,
    required TextStyle titleStyle,
    required TextStyle bodyStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          const SizedBox(height: 8),
          Text(body, style: bodyStyle),
        ],
      ),
    );
  }
}

/// ----------------- CONTENT SECTION MODEL -----------------
class ContentSection {
  final String titleKey;
  final String bodyKey;

  const ContentSection({required this.titleKey, required this.bodyKey});
}

/// ----------------- CONTENT DATA HELPERS -----------------
class ContentData {
  static List<ContentSection> getAboutSections() {
    return const [
      ContentSection(titleKey: 'about.title', bodyKey: 'about.description'),
      ContentSection(
        titleKey: 'about.mission_title',
        bodyKey: 'about.mission_description',
      ),
      ContentSection(
        titleKey: 'about.contact_title',
        bodyKey: 'about.contact_info',
      ),
    ];
  }

  static List<ContentSection> getPrivacyPolicySections() {
    return const [
      ContentSection(
        titleKey: 'privacy_policy.section_1_title',
        bodyKey: 'privacy_policy.section_1_body',
      ),
      ContentSection(
        titleKey: 'privacy_policy.section_2_title',
        bodyKey: 'privacy_policy.section_2_body',
      ),
      ContentSection(
        titleKey: 'privacy_policy.section_3_title',
        bodyKey: 'privacy_policy.section_3_body',
      ),
      ContentSection(
        titleKey: 'privacy_policy.section_4_title',
        bodyKey: 'privacy_policy.section_4_body',
      ),
      ContentSection(
        titleKey: 'privacy_policy.section_5_title',
        bodyKey: 'privacy_policy.section_5_body',
      ),
      ContentSection(
        titleKey: 'privacy_policy.section_6_title',
        bodyKey: 'privacy_policy.section_6_body',
      ),
    ];
  }

  static List<ContentSection> getHelpSections() {
    return const [
      ContentSection(
        titleKey: 'help.how_to_use_title',
        bodyKey: 'help.how_to_use_body',
      ),
      ContentSection(
        titleKey: 'help.need_help_title',
        bodyKey: 'help.need_help_body',
      ),
    ];
  }
}
