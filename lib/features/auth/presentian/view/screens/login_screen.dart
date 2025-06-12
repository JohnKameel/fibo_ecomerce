import 'package:flutter/material.dart';

import '../../../../../core/widgets/spacing_widget.dart';
import '../widgets/login_screen_form.dart';
import '../widgets/login_screen_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  LoginScreenLogo(),
                  HeightSpace(90),
                  LoginScreenItems(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
