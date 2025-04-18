import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class ServicesListViewItem extends StatelessWidget {
  final ServiceData? categoryResponseModel;
  final int indexItem;
  final double radius;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const ServicesListViewItem({
    super.key,
    this.categoryResponseModel,
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CategoryImage(
                imageUrl: categoryResponseModel?.imageCover,
                radius: radius,
                backgroundColor: backgroundColor,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Barber name
                    Text(
                      categoryResponseModel?.name ?? 'Barber',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Rating display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 2),
                        Text(
                          categoryResponseModel?.name ?? 'Unknown',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '(${categoryResponseModel!.price})',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          '(${categoryResponseModel!.duration})',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          '(${categoryResponseModel!.description})',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    )
                  ],
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

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.2),
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
        ),
      ],
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
