import 'package:flutter/material.dart';
import 'package:temy_barber/features/category_barbers/data/models/service_response.dart';
import 'package:temy_barber/features/home/ui/widgets/category/category_list_view_item.dart';
import 'package:temy_barber/core/routing/routes.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryData> categoryDataList;
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
    // Use LayoutBuilder for accurate width within parent padding
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth - 8; // grid padding
        final int crossAxisCount = _getResponsiveColumnCount(availableWidth);
        final double itemWidth =
            (availableWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
        final double cardRadius = itemWidth * 0.45;

        // Calculate the number of items to show
        final int itemCount = categoryDataList.length;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.72,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing * 1.5,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return CategoryListViewItem(
                categoryResponseModel: categoryDataList[index],
                indexItem: index,
                radius: cardRadius, // Responsive radius derived from grid cell
                onTap: () {
                  debugPrint(
                    'Category tapped: ${categoryDataList[index].name}',
                  );

                  Navigator.of(context).pushNamed(
                    Routes.categoryBarbersScreen,
                    arguments: categoryDataList[index].id ?? '',
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  int _getResponsiveColumnCount(double width) {
    if (width >= 1200) return 8; // Large Desktop
    if (width >= 1024) return 6; // Desktop
    if (width >= 768) return 5; // Tablet landscape
    if (width >= 600) return 4; // Tablet portrait
    return 3; // Mobile
  }
}
