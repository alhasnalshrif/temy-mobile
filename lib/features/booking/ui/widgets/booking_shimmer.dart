import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';

/// A specialized shimmer loading widget that matches the layout of the booking cards.
class BookingShimmer extends StatelessWidget {
  final bool showActiveBookings;
  final bool showStatusStepper;

  const BookingShimmer({
    super.key,
    this.showActiveBookings = true,
    this.showStatusStepper = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Shimmer (already shown in parent)
          if (showStatusStepper) _buildStatusStepperShimmer(),
          verticalSpace(16),
          _buildBookingCardShimmer(),
          verticalSpace(24),
          _buildBookingCardShimmer(),
        ],
      ),
    );
  }

  Widget _buildStatusStepperShimmer() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3, // Number of status steps
          (index) => Column(
            children: [
              ShimmerLoading.circular(
                size: 40,
                // Highlight current tab if active bookings is showing
                baseColor: showActiveBookings ? null : Colors.grey[400],
              ),
              verticalSpace(8),
              ShimmerLoading.rectangular(
                height: 12,
                width: 60,
                borderRadius: BorderRadius.circular(4),
                // Highlight current tab if active bookings is showing
                baseColor: showActiveBookings ? null : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCardShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barber section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading.circular(size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(
                      height: 18,
                      width: 120,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    ShimmerLoading.rectangular(
                      height: 14,
                      width: 150,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ShimmerLoading.rectangular(
                          height: 14,
                          width: 80,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status indicator or cancel button
              ShimmerLoading.rectangular(
                height: 32,
                width: 70,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),

          // Date and time section
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(
                      height: 14,
                      width: 80,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    ShimmerLoading.rectangular(
                      height: 16,
                      width: 140,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(
                      height: 14,
                      width: 80,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    ShimmerLoading.rectangular(
                      height: 16,
                      width: 120,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),

          // Services section
          ShimmerLoading.rectangular(
            height: 14,
            width: 100,
            borderRadius: BorderRadius.circular(4),
          ),
          verticalSpace(8),

          // First service item
          _buildServiceItemShimmer(),
          verticalSpace(8),
          // Second service item
          _buildServiceItemShimmer(),

          // Show more button
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ShimmerLoading.rectangular(
                height: 14,
                width: 100,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItemShimmer() {
    return Row(
      children: [
        ShimmerLoading.circular(size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading.rectangular(
                height: 14,
                width: 180,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 4),
              ShimmerLoading.rectangular(
                height: 12,
                width: 60,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
        ShimmerLoading.rectangular(
          height: 14,
          width: 40,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
