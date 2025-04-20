import 'package:flutter/material.dart';
import 'package:temy_barber/features/home/data/models/barber_response.dart';
import 'package:temy_barber/features/home/ui/widgets/category_list_view_item.dart';
import 'package:temy_barber/core/routing/routes.dart';

class CategoryListView extends StatelessWidget {
  final List<BarberData?> categoryDataList;
  final double spacing;
  final int maxItems;

  const CategoryListView({
    super.key,
    required this.categoryDataList,
    this.spacing = 8.0,
    this.maxItems = 6,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate crossAxisCount based on screen width with better breakpoints
    final double screenWidth = MediaQuery.of(context).size.width;
    late final int crossAxisCount;

    if (screenWidth > 900) {
      crossAxisCount = 6; // Very large screens
    } else if (screenWidth > 600) {
      crossAxisCount = 4; // Tablet size
    } else if (screenWidth > 400) {
      crossAxisCount = 3; // Normal phones
    } else {
      crossAxisCount = 2; // Small phones
    }

    // Calculate the number of items to show
    final int itemCount = categoryDataList.length;
    // categoryDataList.length > maxItems ? maxItems : categoryDataList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.85, // Better aspect ratio for category items
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing * 1.5,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // Calculate a staggered animation delay based on index
          return CategoryListViewItem(
            categoryResponseModel: categoryDataList[index],
            indexItem: index,
            radius: (screenWidth / crossAxisCount) * 0.3, // Responsive radius
            onTap: () {
              // Navigate to CategoryScreen with category id
              debugPrint('Category tapped: ${categoryDataList[index]?.name}');

              Navigator.of(context).pushNamed(
                Routes.barberScreen,
                arguments: categoryDataList[index]?.id ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
