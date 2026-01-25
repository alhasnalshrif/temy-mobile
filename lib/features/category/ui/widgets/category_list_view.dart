import 'package:flutter/material.dart';
import 'package:temy_barber/features/category/data/models/categories_list_response.dart';
import 'package:temy_barber/features/category/ui/widgets/category_list_view_item.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/helpers/extensions.dart';

class CategoryBarberListView extends StatelessWidget {
  final List<CategoryItem?> barberDataList;
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
    final int itemCount = barberDataList.length > maxItems
        ? maxItems
        : barberDataList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.8,
        ),
        itemBuilder: (context, index) {
          return CategoryListViewItem(
            serviceResponseModel: barberDataList[index],
            indexItem: index,
            radius: 36, // Fixed size for better consistency
            onTap: () {
              debugPrint('Category tapped: ${barberDataList[index]?.name}');

              context.goNamed(
                AppRoutes.categoryBarbersName,
                pathParameters: {'categoryId': barberDataList[index]?.id ?? ''},
              );
            },
          );
        },
      ),
    );
  }
}
