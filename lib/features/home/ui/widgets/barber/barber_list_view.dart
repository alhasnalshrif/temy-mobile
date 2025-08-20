import 'package:flutter/material.dart';
import 'package:temy_barber/features/home/data/models/barber_response.dart';
import 'package:temy_barber/features/home/ui/widgets/barber/barber_list_view_item.dart';
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


    // Calculate the number of items to show
    final int itemCount = categoryDataList.length;
    // categoryDataList.length > maxItems ? maxItems : categoryDataList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(height: spacing * 1.5),
        itemBuilder: (context, index) {
          return CategoryListViewItem(
            categoryResponseModel: categoryDataList[index],
            indexItem: index,
            radius: screenWidth * 0.12, // responsive radius for list layout
            onTap: () {
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
