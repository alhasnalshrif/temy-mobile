import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view_item.dart';

class ServicesListView extends StatefulWidget {
  final List<ServiceData?> booking;

  const ServicesListView({
    super.key,
    required this.booking,
  });

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  bool _isExpanded = false;
  double _calculateTotalPrice() {
    double total = 0;
    for (var service in widget.booking) {
      if (service?.price != null) {
        // Convert the price to a string before parsing
        total += double.tryParse(service!.price.toString()) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Early return if empty
    if (widget.booking.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'booking.no_services'.tr(),
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
        // Section header with expand/collapse button
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/scissors.png',
                      height: 40,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'booking.service_selected'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), // Summary row that's always visible
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.list_alt, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '${widget.booking.length} ${'booking.services'.tr()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'EGP ${_calculateTotalPrice().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (!_isExpanded) const SizedBox(width: 8),
                    if (!_isExpanded)
                      const Icon(Icons.info_outline,
                          size: 16, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ), // Expandable services list
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.booking.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.withOpacity(0.1),
              ),
              itemBuilder: (context, index) {
                return ServicesListViewItem(
                  service: widget.booking[index],
                );
              },
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
