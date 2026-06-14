import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_inputs.dart';
import '../../widgets/app_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var isLoading = false;

  Future<void> submitLogin() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    setState(() => isLoading = true);
    // fake api hit
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => isLoading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  String? checkEmail(String? v) {
    if (v == null || v.isEmpty) return 'reqired';
    if (!v.contains('@')) return 'invalid';
    return null;
  }

  String? checkPass(String? v) {
    if (v == null || v.isEmpty) return 'reqired';
    if (v.length < 6) return 'short';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Gaps.lg),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Gaps.xxl),
                const Icon(Icons.favorite_rounded, size: 48, color: AppColors.primary),
                const SizedBox(height: Gaps.lg),
                const Text('Welcome Back', style: AppTypography.h1),
                const SizedBox(height: Gaps.xs),
                Text('Sign in to continue to Pulse', style: AppTypography.body.copyWith(color: AppColors.txtSecondary)),

                const SizedBox(height: 48),

                AppTextField(
                  hint: 'Email Address', kbType: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email_outlined, size: 20),
                  validator: checkEmail,
                ),
                const SizedBox(height: Gaps.md),
                PasswordInput(validator: checkPass),

                const SizedBox(height: Gaps.lg),
                Align(alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: const Text('Forgot Password?'))),

                const SizedBox(height: Gaps.xl),
                PrimaryBtn(lbl: 'Sign In', loading: isLoading, onPressed: submitLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
