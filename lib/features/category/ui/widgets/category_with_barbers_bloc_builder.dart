import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/category/data/models/category_response.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/logic/category_state.dart';
import 'package:temy_barber/features/category/ui/widgets/category_list_view.dart';

class CategoryWithBarbersBlocBuilder extends StatelessWidget {
  const CategoryWithBarbersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryWithBarbersLoading ||
          current is CategoryWithBarbersSuccess ||
          current is CategoryWithBarbersError,
      builder: (context, state) {
        return state.maybeMap(
          categoryWithBarbersLoading: (_) => setupLoading(),
          categoryWithBarbersSuccess: (successState) =>
              setupSuccess(successState.categoryServicesResponse, context),
          categoryWithBarbersError: (_) => setupError(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget setupLoading() {
    return Center(
      child: ShimmerLoading.rectangular(height: 400),
    );
  }

  Widget setupSuccess(
      CategoryServicesResponseModel response, BuildContext context) {
    // final category = response.data?.category;
    final barbers = response.data?.barbers ?? [];

    if (barbers.isEmpty) {
      return const Center(
        child: Text('No barbers available for this category'),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryBarberListView(barberDataList: barbers),

          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: barbers.length,
          //     itemBuilder: (context, index) {
          //       final barber = barbers[index];
          //       return BarberCard(barber: barber);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget setupError() {
    return const Center(
      child: Text('Failed to load barbers'),
    );
  }
}

// class BarberCard extends StatelessWidget {
//   final barbers barber;

//   const BarberCard({super.key, required this.barber});

//   @override
//   Widget build(BuildContext context) {
//     final services = barber.services ?? [];
//     final themeColor = Theme.of(context).primaryColor;

//     return GestureDetector(
//       onTap: () {
//         // Navigate to CategoryScreen with category id

//         Navigator.of(context).pushNamed(
//           Routes.barberScreen,
//           arguments: barber.id,
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Barber header with image and info
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: themeColor.withOpacity(0.05),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 32,
//                   backgroundColor: themeColor.withOpacity(0.2),
//                   child: const Icon(
//                     Icons.person,
//                     size: 32,
//                     color: Colors.white,
//                   ),
//                 ),
//                 horizontalSpace(16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         barber.name ?? 'Barber',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (barber.phone != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.phone,
//                                 size: 16,
//                                 color: Colors.grey[600],
//                               ),
//                               horizontalSpace(4),
//                               Text(
//                                 barber.phone!,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: themeColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "${services.length} services",
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Services list
//         ],
//       ),
//     );
//   }
// }
