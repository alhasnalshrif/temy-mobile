import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/widgets/app_text_form_field.dart';
import 'package:temy_barber/features/verification/logic/verification_cubit.dart';
import 'package:temy_barber/features/verification/ui/widgets/verification_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const VerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    // Set the phone number for verification when the screen is built
    context.read<VerificationCubit>().setPhoneNumber(phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('التحقق من الحساب', style: TextStyles.font18WhiteBold),
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.verified_user_outlined,
                    size: 80, color: ColorsManager.mainBlue),
                verticalSpace(24),
                Text(
                  'تحقق من هاتفك',
                  style: TextStyles.font26BlueBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(12),
                Text(
                  'لقد أرسلنا رمز التحقق إلى رقم هاتفك $phoneNumber',
                  style: TextStyles.font16GrayRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(36),
                Form(
                  key: context.read<VerificationCubit>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رمز التحقق',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      verticalSpace(12),
                      AppTextFormField(
                        hintText: '123456',
                        keyboardType: TextInputType.number,
                        controller:
                            context.read<VerificationCubit>().codeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال رمز التحقق';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(40),
                      AppTextButton(
                        buttonText: "تحقق",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          validateThenVerify(context);
                        },
                      ),
                      verticalSpace(24),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Call the resend code functionality
                            context.read<VerificationCubit>().resendCode();

                            // Show a snackbar to indicate the code was resent
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text('verification.resend_code_success'.tr()),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: Text(
                            'إعادة إرسال الرمز',
                            style: TextStyles.font14BlueSemiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerificationBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenVerify(BuildContext context) {
    if (context.read<VerificationCubit>().formKey.currentState!.validate()) {
      context.read<VerificationCubit>().verifyCode();
    }
  }
}
