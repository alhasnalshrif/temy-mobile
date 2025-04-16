import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/logic/home_state.dart';
import 'package:temy_barber/features/home/ui/widgets/banner_carousel.dart';

class BannerBlocBuilder extends StatelessWidget {
  const BannerBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is BannersLoading ||
          current is BannersSuccess ||
          current is BannersError,
      builder: (context, state) {
        return state.maybeMap(
          bannersLoading: (value) {
            return _buildLoading();
          },
          bannersSuccess: (bannersResponse) {
            final banners =
                bannersResponse.bannersResponseModel.bannerDataList ?? [];
            if (banners.isEmpty) {
              return const SizedBox.shrink();
            }
            return BannerCarousel(banners: banners);
          },
          bannersError: (errorHandler) => _buildError(),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return const SizedBox.shrink();
  }
}
