import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/style/app_assets.dart';
import 'package:fido_e/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/router_app.dart';
import '../../../core/style/app_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../core/widgets/spacing_widget.dart';
import '../../../generated/locale_keys.g.dart';

class RegisOrLogScreen extends StatelessWidget {
  const RegisOrLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(AppAssets.logoPath)),
              HeightSpace(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LocaleKeys.Auth_Welcome_to.tr(), style: AppStyles.text24,),
                  const SizedBox(width: 5),
                  Text('Fibo', style: AppStyles.text24blue),
                ],
              ),
              HeightSpace(60),
              CustomPrimaryButton(
                buttonText: LocaleKeys.Auth_Login.tr(),
                textColor: AppColors.blackText,
                buttonColor: AppColors.primary,
                bordersRadius: 8,
                height: 50.h,
                width: 371.w,
                onPress: () {
                  context.go(RouterApp.login);
                },
              ),
              HeightSpace(30),
              CustomPrimaryButton(
                buttonText: LocaleKeys.Auth_Register.tr(),
                buttonColor: AppColors.primaryColor,
                bordersRadius: 8,
                height: 50.h,
                width: 371.w,
                textColor: AppColors.primary,
                onPress: () {
                  context.go(RouterApp.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
