// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:temy_barber/core/helpers/spacing.dart';
// import 'package:temy_barber/core/theme/colors.dart';
// import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
// import 'package:temy_barber/features/booking/logic/booking_state.dart';
// import 'package:temy_barber/features/booking/ui/widgets/category_list_view.dart';

// class BookingBlocBuilder extends StatelessWidget {
//   const BookingBlocBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BookingCubit, BookingState>(
//       buildWhen: (previous, current) =>
//           current is BookingLoading ||
//           current is BookingSuccess ||
//           current is BookingError,
//       builder: (context, state) {
//         return state.maybeMap(
//           bookingLoading: (value) {
//             return setupLoading(context);
//           },
//           bookingSuccess: (barbersResponseModel) {
//             var barbersList =
//                 barbersResponseModel.bookingResponseModel.bookingDataList;
//             return setupSuccess(context, barbersList);
//           },
//           bookingError: (errorHandler) =>
//               setupError(context, ''),
//           orElse: () {
//             return const SizedBox.shrink();
//           },
//         );
//       },
//     );
//   }

//   Widget setupLoading(BuildContext context) {
//     // Use shimmering loading effect for better UX
//     return Expanded(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 150,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 70,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 0.85,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 18,
//               ),
//               itemCount: 6,
//               itemBuilder: (context, index) {
//                 return _buildShimmerItem();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmerItem() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 1,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             margin: const EdgeInsets.only(top: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           verticalSpace(8),
//           Container(
//             width: 80,
//             height: 12,
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           verticalSpace(4),
//           Container(
//             width: 60,
//             height: 8,
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget setupSuccess(BuildContext context, barbersList) {
//     // If there's data, show the list
//     if (barbersList != null && barbersList.isNotEmpty) {
//       return Expanded(
//         child: RefreshIndicator(
//           onRefresh: () async {
//             context.read<BookingCubit>().getBooking();
//           },
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 CategoryListView(
//                   categoryDataList: barbersList,
//                   title: 'Our Expert Barbers',
//                   maxItems: 100,
//                 ),
//                 verticalSpace(24),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     // If there's no data, show empty state
//     else {
//       return Expanded(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
            
//               verticalSpace(16),
//               Text(
//                 'No barbers available',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Colors.grey[700],
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               verticalSpace(8),
//               Text(
//                 'Please check back later for available barbers',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//               ),
//               verticalSpace(24),
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<BookingCubit>().getBooking();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorsManager.main2Blue,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Refresh',
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }

//   Widget setupError(BuildContext context, String errorMessage) {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 64,
//               color: Colors.red[400],
//             ),
//             verticalSpace(16),
//             Text(
//               'Oops! Something went wrong',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     color: Colors.grey[800],
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             verticalSpace(8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Text(
//                 errorMessage,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//               ),
//             ),
//             verticalSpace(24),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<BookingCubit>().getBooking();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorsManager.main2Blue,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Try Again',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
