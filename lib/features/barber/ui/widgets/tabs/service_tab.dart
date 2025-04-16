import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: services.isEmpty
          ? const Center(child: Text('No services available.'))
          : ListView.separated(
              itemCount: services.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final service = services[index];
                final isSelected = selectedServices?.any((selectedService) =>
                        selectedService.id == service.id) ??
                    false;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onServiceSelected == null
                      ? null
                      : () => onServiceSelected!(
                            service,
                            service.price.toDouble(),
                            !isSelected,
                          ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 0,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(service.imageCover),
                        backgroundColor: Colors.grey[200],
                      ),
                      title: Text(
                        service.name,
                        style: TextStyles.font18DarkSemiBold,
                      ),
                      subtitle: Text(
                        service.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'EGP ${service.price.toStringAsFixed(0)}',
                            style: TextStyles.font16DarkBold,
                          ),
                          const SizedBox(height: 4),
                          Text('Min ${service.duration}',
                              style: TextStyles.font14DarkBlueMedium),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
