import 'package:fido_e/core/widgets/spacing_widget.dart';
import 'package:fido_e/features/auth/presentian/view/widgets/register_screen_form.dart';
import 'package:fido_e/features/auth/presentian/view/widgets/register_screen_logo.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  RegisterScreenLogo(),
                  HeightSpace(40),
                  RegisterScreenForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
