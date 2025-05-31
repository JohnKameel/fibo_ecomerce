import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/routing/router_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_assets.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_styles.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../../../generated/locale_keys.g.dart';

class LoginScreenItems extends StatelessWidget {
  const LoginScreenItems({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: LocaleKeys.Auth_email.tr(),
        ),
        HeightSpace(20),
        CustomTextField(
          controller: passwordController,
          hintText: LocaleKeys.Auth_password.tr(),
          isPassword: true,
        ),
        HeightSpace(55),
        CustomPrimaryButton(
          buttonText: LocaleKeys.Auth_Login.tr(),
          textColor: AppColors.primary,
          buttonColor: AppColors.primaryColor,
          bordersRadius: 8,
          onPress: () {
            context.go(RouterApp.map);
          },
        ),
        HeightSpace(200),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.Auth_Do_not_have_an_account_yet.tr(),
              style: AppStyles.text14,
            ),
            TextButton(
              onPressed: () {
                context.go(RouterApp.register);
              },
              child: Text(
                LocaleKeys.Auth_Register.tr(),
                style: AppStyles.text14bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
