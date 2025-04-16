// import 'package:flutter/material.dart';
// import 'package:temy_barber/features/booking/ui/widgets/category_list_view_item.dart';
// import 'package:temy_barber/core/routing/routes.dart';

// class CategoryListView extends StatelessWidget {
//   final List<BarberData?> categoryDataList;
//   final double spacing;
//   final int maxItems;
//   final String title;
//   final VoidCallback? onViewAllTapped;

//   const CategoryListView({
//     super.key,
//     required this.categoryDataList,
//     this.spacing = 12.0,
//     this.maxItems = 6,
//     this.title = 'Available Barbers',
//     this.onViewAllTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Calculate crossAxisCount based on screen width with better breakpoints
//     final double screenWidth = MediaQuery.of(context).size.width;
//     late final int crossAxisCount;

//     if (screenWidth > 900) {
//       crossAxisCount = 6; // Very large screens
//     } else if (screenWidth > 600) {
//       crossAxisCount = 4; // Tablet size
//     } else if (screenWidth > 400) {
//       crossAxisCount = 3; // Normal phones
//     } else {
//       crossAxisCount = 2; // Small phones
//     }

//     // Calculate the number of items to show
//     final int itemCount =
//         categoryDataList.length > maxItems ? maxItems : categoryDataList.length;

//     // Early return if empty
//     if (categoryDataList.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
//               const SizedBox(height: 16),
//               Text(
//                 'No barbers available at the moment',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section header with view all option
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//               ),
//               if (categoryDataList.length > maxItems && onViewAllTapped != null)
//                 TextButton(
//                   onPressed: onViewAllTapped,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'View All',
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Icon(
//                         Icons.chevron_right,
//                         size: 18,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Barber grid with staggered animations
//          Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio:
//                     0.85, // Better aspect ratio for category items
//                 crossAxisSpacing: spacing,
//                 mainAxisSpacing: spacing * 1.5,
//               ),
//               itemCount: itemCount,
//               itemBuilder: (context, index) {
//                 // Calculate a staggered animation delay based on index
//                 return AnimationConfiguration.staggeredGrid(
//                   position: index,
//                   duration: const Duration(milliseconds: 450),
//                   columnCount: crossAxisCount,
//                   child: CategoryListViewItem(
//                         categoryResponseModel: categoryDataList[index],
//                         indexItem: index,
//                         radius: (screenWidth / crossAxisCount) *
//                             0.3, // Responsive radius
//                         onTap: () {
//                           // Navigate to CategoryScreen with category id
//                           debugPrint(
//                               'Category tapped: ${categoryDataList[index]?.name}');

//                           Navigator.of(context).pushNamed(
//                             Routes.barberScreen,
//                             arguments: categoryDataList[index]?.id ?? '',
//                           );
//                         },
//                       ),
                    
                
//                 );
//               },
//             ),
//           ),
        
//       ],
//     );
//   }
// }
