import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceTab extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;
  final Set<BarberService>? selectedServices;
  final void Function(BarberService service, double price, bool selected)?
  onServiceSelected;

  const ServiceTab({
    super.key,
    this.serviceResponseModel,
    this.selectedServices,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final services = serviceResponseModel?.services ?? [];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (services.isEmpty) {
          return Center(
            child: Text(
              'barber.no_services'.tr(),
              style: TextStyles.font16GrayRegular,
            ),
          );
        }

        final width = constraints.maxWidth;
        // Target card width around 300-400px
        int crossAxisCount = (width / 350).floor();
        if (crossAxisCount < 1) crossAxisCount = 1;

        // Ensure single column on mobile
        if (ResponsiveUtils.isMobile(context)) {
          crossAxisCount = 1;
        }

        const double spacing = 16.0;
        final double totalSpacing = (crossAxisCount - 1) * spacing;
        final double itemWidth = (width - totalSpacing) / crossAxisCount;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: services.map((service) {
              final isSelected =
                  selectedServices?.any(
                    (selectedService) => selectedService.id == service.id,
                  ) ??
                  false;

              return SizedBox(
                width: itemWidth,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsManager.mainBlue.withAlpha(8)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? ColorsManager.mainBlue
                          : ColorsManager.lighterGray,
                      width: isSelected ? 2 : 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onServiceSelected == null
                          ? null
                          : () => onServiceSelected!(
                              service,
                              service.price.toDouble(),
                              !isSelected,
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorsManager.mainBlue
                                    : ColorsManager.moreLighterGray,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : ColorsManager.lightGray,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style: isSelected
                                        ? TextStyles.font16DarkBold
                                        : TextStyles.font15DarkBlueMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 16,
                                        color: ColorsManager.gray,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'barber.duration'.tr(
                                          args: [service.duration.toString()],
                                        ),
                                        style: TextStyles.font13GrayRegular,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorsManager.mainBlue
                                    : ColorsManager.thirdfMain,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'barber.price'.tr(
                                  args: [service.price.toString()],
                                ),
                                style: isSelected
                                    ? TextStyles.font16WhiteSemiBold
                                    : TextStyles.font14BlueSemiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
