import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class BarberImage extends StatelessWidget {
  final String? imageUrl;

  const BarberImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 120;
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: double.infinity,
                height: height,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => _buildShimmer(height),
                errorWidget: (context, url, error) => _buildError(height),
              )
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }

  Widget _buildShimmer(double height) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: height,
          color: Colors.white,
        ),
      );

  Widget _buildError(double height) => Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[100],
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
        ),
      );
}
