import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/home/data/models/banner_response.dart';
import 'package:shimmer/shimmer.dart';

class BannerCarousel extends StatefulWidget {
  final List<BannerData> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = _getResponsiveBannerHeight(screenWidth);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,
          options: CarouselOptions(
            height: bannerHeight,
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = widget.banners[index];
            return _BannerItem(imageUrl: banner.image);
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.mainBlue.withOpacity(
                  _currentIndex == entry.key ? 0.9 : 0.4,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  double _getResponsiveBannerHeight(double screenWidth) {
    if (screenWidth >= 1024) return 300; // Desktop
    if (screenWidth >= 600) return 220; // Tablet
    return 160; // Mobile
  }
}

class _BannerItem extends StatelessWidget {
  final String? imageUrl;

  const _BannerItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => _buildShimmer(),
                errorWidget: (context, url, error) => _buildError(),
              )
            : _buildError(),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(width: double.infinity, color: Colors.white),
    );
  }

  Widget _buildError() {
    return Container(
      width: double.infinity,
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
}
