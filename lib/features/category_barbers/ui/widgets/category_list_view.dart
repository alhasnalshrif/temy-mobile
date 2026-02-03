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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      itemCount: itemCount,
      // Performance optimization: estimate item height
      itemExtent: 100,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final barber = barberDataList[index];
        return CategoryListViewItem(
          key: ValueKey(barber?.id ?? 'barber_$index'),
          serviceResponseModel: barber,
          indexItem: index,
          radius: 32,
          onTap: () {
            if (barber?.id != null) {
              context.goNamed(
                AppRoutes.barberName,
                pathParameters: {'barberId': barber!.id!},
              );
            }
          },
        );
      },
    );
  }
}
