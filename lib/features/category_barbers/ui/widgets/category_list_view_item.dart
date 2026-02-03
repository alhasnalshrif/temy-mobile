import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
      ),
      child: Row(
        children: [
          _CategoryImage(
            imageUrl: serviceResponseModel?.avatar,
            radius: radius,
          ),
          const SizedBox(width: 16),
          Expanded(child: _buildBarberInfo(context)),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: ColorsManager.mainBlue.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  /// Builds the barber information with name.
  Widget _buildBarberInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          serviceResponseModel?.name ?? 'Service',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorsManager.mainBlue,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.4,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
