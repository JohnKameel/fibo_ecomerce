import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/widgets/custom_primary_button.dart';
import 'package:fido_e/core/widgets/spacing_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/router_app.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/locale_keys.g.dart';

class RegisterScreenForm extends StatelessWidget {
  const RegisterScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          hintText: LocaleKeys.Auth_Full_Name.tr(),
        ),
        HeightSpace(30),
        CustomTextField(
          controller: userNameController,
          hintText: LocaleKeys.Auth_username.tr(),
        ),
        HeightSpace(30),
        CustomTextField(
          controller: passwordController,
          hintText: LocaleKeys.Auth_password.tr(),
          isPassword: true,
        ),
        HeightSpace(30),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: LocaleKeys.Auth_Confirm_Password.tr(),
          isPassword: true,
        ),
        HeightSpace(50),
        CustomPrimaryButton(
          buttonText: LocaleKeys.Auth_Register.tr(),
          textColor: AppColors.primary,
          buttonColor: AppColors.primaryColor,
          bordersRadius: 8,
          onPress: () {
            context.go(RouterApp.map);
          },
        ),
        HeightSpace(90),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.Auth_Already_have_an_account.tr(),
              style: AppStyles.text14,
            ),
            TextButton(
              onPressed: () {
                context.go(RouterApp.login);
              },
              child: Text(
                LocaleKeys.Auth_Login.tr(),
                style: AppStyles.text14bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
