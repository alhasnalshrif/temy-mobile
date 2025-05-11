import 'package:flutter/material.dart';
import 'package:temy_barber/features/category/data/models/category_response.dart';
import 'package:temy_barber/features/category/ui/widgets/category_list_view_item.dart';
import 'package:temy_barber/core/routing/routes.dart';

class CategoryBarberListView extends StatelessWidget {
  final List<BarberData?> barberDataList;
  final double spacing;
  final int maxItems;

  const CategoryBarberListView({
    super.key,
    required this.barberDataList,
    this.spacing = 8.0,
    this.maxItems = 6,
  });

  @override
  Widget build(BuildContext context) {
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

    final int itemCount = barberDataList.length > maxItems
        ? maxItems
        : barberDataList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.85, 
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing * 1.5,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return CategoryListViewItem(
            serviceResponseModel: barberDataList[index],
            indexItem: index,
            radius: (screenWidth / crossAxisCount) * 0.3, 
            onTap: () {
              debugPrint(
                  'Category tapped: ${barberDataList[index]?.name}');

              Navigator.of(context).pushNamed(
                Routes.barberScreen,
                arguments: barberDataList[index]?.id,
              );
            },
          );
        },
      ),
    );
  }
}
