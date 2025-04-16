import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/home/ui/widgets/banner_bloc_builder.dart';
import 'package:temy_barber/features/home/ui/widgets/category_sea_all.dart';
import 'package:temy_barber/features/home/ui/widgets/home_top_bar.dart';
import 'package:temy_barber/features/home/ui/widgets/home_bloc_builder.dart';

// import 'widgets/banner_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              verticalSpace(24),
              const BannerBlocBuilder(),
              // const BannerCard(),
              verticalSpace(24),
              const DoctorSpecialitySeaAll(),
              verticalSpace(10),
              const HomeBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
