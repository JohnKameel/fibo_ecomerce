import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/widgets/custom_primary_button.dart';
import 'package:fido_e/core/widgets/spacing_widget.dart';
import 'package:fido_e/features/auth/data/model/user_model.dart';
import 'package:fido_e/features/auth/presentian/viewModel/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/router_app.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_styles.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../generated/locale_keys.g.dart';

class RegisterScreenForm extends StatelessWidget {
  const RegisterScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: LocaleKeys.Auth_email.tr(),
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

        HeightSpace(50),
        BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.go(RouterApp.map);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome ${state.user.username}'), backgroundColor: Colors.green,),
              );
            }
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return CustomPrimaryButton(
              buttonText: LocaleKeys.Auth_Register.tr(),
              textColor: AppColors.primary,
              buttonColor: AppColors.primaryColor,
              bordersRadius: 8,
              onPress: () {
                context.read<RegisterCubit>().register(
                      userNameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
              },
            );
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
