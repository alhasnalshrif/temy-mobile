import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

class BookingStatusStepper extends StatelessWidget {
  final String status;

  const BookingStatusStepper({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine active step based on status
    int activeStep = 0;
    if (status == 'confirmed') activeStep = 1;
    // Add more steps if needed (e.g., 'on the way', 'in progress')

    // Define icons and labels for each step
    final steps = [
      {'icon': Icons.calendar_month_outlined, 'label': 'Booked'},
      {'icon': Icons.access_time_rounded, 'label': 'Confirmed'},
      {'icon': Icons.check_circle_outline, 'label': 'Finished'},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                int stepIndex = index ~/ 2;
                return _buildStatusIndicator(
                  context,
                  steps[stepIndex]['icon'] as IconData,
                  isActive: stepIndex <= activeStep,
                );
              } else {
                int connectorIndex = (index - 1) ~/ 2;
                return _buildStatusConnector(
                    isActive: connectorIndex < activeStep);
              }
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              return _buildStatusText(
                steps[index]['label'] as String,
                isActive: index <= activeStep,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(BuildContext context, IconData icon,
      {required bool isActive}) {
    return Container(
      width: 36, // Slightly smaller
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? ColorsManager.mainBlue : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20, // Slightly smaller icon
        color: isActive ? Colors.white : Colors.grey[500],
      ),
    );
  }

  Widget _buildStatusConnector({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? ColorsManager.mainBlue : Colors.grey[300],
      ),
    );
  }

  Widget _buildStatusText(String text, {required bool isActive}) {
    return Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11, // Smaller font
          color: isActive ? ColorsManager.mainBlue : Colors.grey[600],
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
