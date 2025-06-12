import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/app_assets.dart';
import '../../../../../core/style/app_styles.dart';
import '../../../../../generated/locale_keys.g.dart';

class RegisterScreenLogo extends StatelessWidget {
  const RegisterScreenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Image(image: AssetImage(AppAssets.logoPath)),
          Text(
            LocaleKeys.Auth_Create_account.tr(),
            style: AppStyles.text32,
          ),
          Text(
            LocaleKeys.Auth_Let_is_create_your_account.tr(),
            style: AppStyles.text16,
          ),
        ],
    );
  }
}
