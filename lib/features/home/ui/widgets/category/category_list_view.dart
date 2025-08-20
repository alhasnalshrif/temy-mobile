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
    // Calculate crossAxisCount based on screen width with better breakpoints
    final double screenWidth = MediaQuery.of(context).size.width;

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
          crossAxisCount: 3,
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
            radius: (screenWidth / 3) * 0.3, // Responsive radius
            onTap: () {
              debugPrint('Category tapped: ${categoryDataList[index].name}');

              Navigator.of(context).pushNamed(
                Routes.categoryBarbersScreen,
                arguments: categoryDataList[index].id ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
