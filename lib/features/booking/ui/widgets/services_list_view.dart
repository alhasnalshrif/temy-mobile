import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view_item.dart';

class ServicesListView extends StatefulWidget {
  final List<ServiceData?> booking;

  const ServicesListView({super.key, required this.booking});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  bool _isExpanded = false;
  double _calculateTotalPrice() {
    double total = 0;
    for (var service in widget.booking) {
      if (service?.price != null) {
        total += double.tryParse(service!.price.toString()) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.booking.length} ${'booking.service_selected'.tr()}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      'EGP ${_calculateTotalPrice().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsManager.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorsManager.background,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorsManager.lightBlue),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.booking.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 1,
                color: ColorsManager.lightBlue,
              ),
              itemBuilder: (context, index) {
                return ServicesListViewItem(service: widget.booking[index]);
              },
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
