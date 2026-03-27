import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';
import 'package:easy_localization/easy_localization.dart';

/// A widget that displays a single category item in a list with an image and name.
class CategoryListViewItem extends StatelessWidget {
  final BarberData? serviceResponseModel;
  final int indexItem;
  final double radius;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const CategoryListViewItem({
    super.key,
    this.serviceResponseModel,
    required this.indexItem,
    this.radius = 30,
    this.onTap,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: _buildCard(context),
      ),
    );
  }

  /// Builds the main card with enhanced visual design.
  Widget _buildCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _CategoryImage(
                  imageUrl: serviceResponseModel?.avatar,
                  radius: 34,
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildBarberInfo(context)),
                const SizedBox(width: 8),
                // Book Now Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorsManager.mainBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'default_booking.book_now'.tr(),
                    style: TextStyle(
                      color: ColorsManager.mainBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the barber information with name and additional details.
  Widget _buildBarberInfo(BuildContext context) {
    final int servicesCount = serviceResponseModel?.services?.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          serviceResponseModel?.name ?? 'barber.name'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.cut_rounded, size: 14, color: Colors.grey.shade500),
            const SizedBox(width: 4),
            Text(
              '$servicesCount ${servicesCount == 1 ? 'خدمة' : 'خدمات'}', // Quick Arabic fallback since we don't have tr key
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.star_rounded, color: Colors.orange, size: 15),
            const SizedBox(width: 4),
            Text(
              '5.0',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const _CategoryImage({required this.imageUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.lightBlue.withOpacity(0.3),
            ColorsManager.lightBlue.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipOval(
          child: hasImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 250),
                  fadeOutDuration: const Duration(milliseconds: 150),
                  // Optimized caching strategy
                  memCacheWidth:
                      (size * MediaQuery.of(context).devicePixelRatio).round(),
                  memCacheHeight:
                      (size * MediaQuery.of(context).devicePixelRatio).round(),
                  maxWidthDiskCache: 400,
                  maxHeightDiskCache: 400,
                  placeholder: (context, url) => _buildShimmer(size),
                  errorWidget: (context, url, error) => _buildError(size),
                )
              : _buildFallback(size),
        ),
      ),
    );
  }

  /// Builds a shimmer effect for loading images.
  Widget _buildShimmer(double size) => Shimmer.fromColors(
    baseColor: Colors.grey[200]!,
    highlightColor: Colors.grey[50]!,
    period: const Duration(milliseconds: 1200),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    ),
  );

  /// Builds an error widget for failed image loads.
  Widget _buildError(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
    child: Center(
      child: Icon(
        Icons.person_outline_rounded,
        size: radius * 1.1,
        color: ColorsManager.mainBlue.withOpacity(0.3),
      ),
    ),
  );

  /// Builds a fallback widget for missing images.
  Widget _buildFallback(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorsManager.lightBlue,
          ColorsManager.lightBlue.withOpacity(0.7),
        ],
      ),
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Icon(
        Icons.person_rounded,
        size: radius * 1.1,
        color: Colors.white,
      ),
    ),
  );
}
