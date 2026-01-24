import 'package:flutter/material.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';
import 'package:temy_barber/features/category_barbers/ui/widgets/category_list_view_item.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/helpers/extensions.dart';

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
    final int itemCount = barberDataList.length > maxItems
        ? maxItems
        : barberDataList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(height: spacing),
        itemBuilder: (context, index) {
          return CategoryListViewItem(
            serviceResponseModel: barberDataList[index],
            indexItem: index,
            radius: 36, // Fixed size for better consistency
            onTap: () {
              debugPrint('Category tapped: ${barberDataList[index]?.name}');

              context.pushGoNamed(
                AppRoutes.barberName,
                pathParameters: {'barberId': barberDataList[index]?.id ?? ''},
              );
            },
          );
        },
      ),
    );
  }
}
