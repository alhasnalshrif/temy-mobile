import 'package:flutter/material.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view_item.dart';
import 'package:temy_barber/core/routing/routes.dart';

class ServicesListView extends StatelessWidget {
  final List<ServiceData?> booking;
  // final double spacing;
  // final int maxItems;
  // final String title;
  // final VoidCallback? onViewAllTapped;

  const ServicesListView({
    super.key,
    required this.booking,
    // this.spacing = 12.0,
    // this.maxItems = 6,
    // this.title = 'Available Barbers',
    // this.onViewAllTapped,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Early return if empty
    if (booking.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No services available at the moment',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Service selected',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
        ),

        // Services list with ListView.builder
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: booking.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ServicesListViewItem(
                categoryResponseModel: booking[index],
                indexItem: index,
                radius: screenWidth * 0.1, // Responsive radius
                onTap: () {
                  // Navigate to CategoryScreen with service id
                  debugPrint('Service tapped: ${booking[index]?.name}');

                  Navigator.of(context).pushNamed(
                    Routes.barberScreen,
                    arguments: booking[index]?.id ?? '',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
