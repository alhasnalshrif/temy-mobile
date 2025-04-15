import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_complete_project/features/category/data/models/service_response.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListViewItem extends StatelessWidget {
  final ServiceData? serviceResponseModel;
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CategoryImage(
                imageUrl: serviceResponseModel?.imageCover,
                radius: radius,
                backgroundColor: backgroundColor,
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: radius * 2.5),
                child: Text(
                  serviceResponseModel?.name ?? 'Service',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[800],
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
            : Container(
                color: backgroundColor,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  Widget _buildShimmer(double size) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: size,
          height: size,
          color: Colors.white,
        ),
      );

  Widget _buildError(double size) => Container(
        width: size,
        height: size,
        color: Colors.grey[100],
        child: Center(
          child: Icon(
            Icons.error_outline,
            size: radius * 0.8,
            color: Colors.red.withOpacity(0.7),
          ),
        ),
      );
}
