import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/routing/router_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/style/app_assets.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_styles.dart';
import '../../../../../core/widgets/custom_primary_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/spacing_widget.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/model/user_model.dart';
import '../../viewModel/login_cubit.dart';

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
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.user.username)),
              );
              context.go(RouterApp.map);
            }
            if(state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if(state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomPrimaryButton(
              buttonText: LocaleKeys.Auth_Login.tr(),
              textColor: AppColors.primary,
              buttonColor: AppColors.primaryColor,
              bordersRadius: 8,
              onPress: () {
                context.read<LoginCubit>().login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
            );
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
//