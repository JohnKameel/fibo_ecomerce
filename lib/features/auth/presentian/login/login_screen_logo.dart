import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_assets.dart';
import '../../../../core/style/app_styles.dart';
import '../../../../generated/locale_keys.g.dart';

class LoginScreenLogo extends StatelessWidget {
  const LoginScreenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(AppAssets.logoPath)),
        Text(
          LocaleKeys.Auth_Login_account.tr(),
          style: AppStyles.text32,
        ),
        Text(
          LocaleKeys.Auth_It_is_great_to_see_you_again.tr(),
          style: AppStyles.text16,
        ),
      ],
    );
  }
}
