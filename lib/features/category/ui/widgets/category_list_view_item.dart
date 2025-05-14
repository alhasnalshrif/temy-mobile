import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/features/category/data/models/category_response.dart';

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
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: _buildAnimatedContainer(context),
      ),
    );
  }

  /// Builds the main container with a tap animation.
  Widget _buildAnimatedContainer(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: onTap != null ? 1.0 : 0.98,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _CategoryImage(
              imageUrl: serviceResponseModel?.avatar,
              radius: radius,
              backgroundColor: backgroundColor,
            ),
            const SizedBox(width: 12),
            _buildCategoryName(context),
          ],
        ),
      ),
    );
  }

  /// Builds the category name with responsive text constraints.
  Widget _buildCategoryName(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: radius * 2.5),
      child: Text(
        serviceResponseModel?.name ?? 'Service',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[900],
              height: 1.3,
              fontWeight: FontWeight.w600,
              fontSize: 14 / textScale,
            ),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// A widget that displays the category image with a gradient border.
class _CategoryImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color backgroundColor;

  const _CategoryImage({
    required this.imageUrl,
    required this.radius,
    required this.backgroundColor,
  });

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
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => _buildShimmer(size),
                errorWidget: (context, url, error) => _buildError(size),
              )
            : _buildFallback(size),
      ),
    );
  }

  /// Builds a shimmer effect for loading images.
  Widget _buildShimmer(double size) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: size,
          height: size,
          color: Colors.white,
        ),
      );

  /// Builds an error widget for failed image loads.
  Widget _buildError(double size) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.broken_image,
            size: radius * 0.8,
            color: Colors.red.withOpacity(0.6),
          ),
        ),
      );

  /// Builds a fallback widget for missing images.
  Widget _buildFallback(double size) => Container(
        width: size,
        height: size,
        color: backgroundColor,
        child: Center(
          child: Icon(
            Icons.category,
            size: radius * 0.8,
            color: Colors.grey[600],
          ),
        ),
      );
}
