import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/category/data/models/category_services_response.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/logic/category_state.dart';

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
              setupSuccess(successState.categoryServicesResponse),
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

  Widget setupSuccess(CategoryServicesResponse response) {
    final category = response.data?.category;
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
          if (category != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                category.name ?? 'Category',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                final barber = barbers[index];
                return BarberCard(barber: barber);
              },
            ),
          ),
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

class BarberCard extends StatelessWidget {
  final BarberData barber;

  const BarberCard({super.key, required this.barber});

  @override
  Widget build(BuildContext context) {
    final services = barber.services ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.person),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barber.name ?? 'Barber',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (barber.phone != null)
                        Text(
                          barber.phone!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              'Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(8),
            ...services.map((service) => ServiceItem(service: service)),
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final BarberService service;

  const ServiceItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                    service.imageCover ?? 'https://placehold.co/600x400'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name ?? 'Service',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (service.description != null)
                  Text(
                    service.description!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${service.price?.toStringAsFixed(0) ?? 0} EGP',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${service.duration ?? 0} min',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
