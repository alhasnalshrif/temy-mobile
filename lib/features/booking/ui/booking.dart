import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_bloc_builder_with_queue.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _isGuest = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    setState(() {
      _isGuest = token.isEmpty;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.mainBlue,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'booking.screen_title'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: CircularProgressIndicator(color: ColorsManager.mainBlue),
        ),
      );
    }

    if (_isGuest) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.mainBlue,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'booking.screen_title'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: ColorsManager.mainBlue.withAlpha(128),
                ),
                const SizedBox(height: 24),
                Text(
                  'auth.login_required_title'.tr(),
                  style: TextStyles.font24BlackBold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'auth.login_required_message'.tr(),
                  style: TextStyles.font14GrayRegular,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.loginName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'auth.login_button'.tr(),
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('booking.screen_title'.tr()),
        centerTitle: true,
        backgroundColor: ColorsManager.mainBlue,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        color: ColorsManager.mainBlue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          context.read<BookingCubit>().getBooking();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const BookingBlocBuilderWithQueue(),
            ),
          ),
        ),
      ),
    );
  }
}
