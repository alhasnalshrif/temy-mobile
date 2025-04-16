import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';

class TotalSection extends StatelessWidget {
  final double totalPrice;

  const TotalSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       'مجموع الحساب',
          //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //     ),
          //     Text(
          //       '${totalPrice.toStringAsFixed(0)} EGP',
          //       style:
          //           const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 16),
          // Container(
          //   height: 1,
          //   color: ColorsManager.thirdfMain,
          // ),
          // const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الإجمالي',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    totalPrice.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                  const Text(
                    ' EGP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
