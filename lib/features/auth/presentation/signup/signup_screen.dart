import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/router/app_router.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';
import 'widgets/signup_card.dart';
import 'widgets/signup_hero_section.dart';
import 'widgets/signup_social_section.dart';
import 'widgets/signup_trust_footnote.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;

  Future<void> _handleSignup({
    required String email,
    required String phone,
    required String password,
  }) async {
    final isBengali = AppLanguage.current;
    Helpers.hideKeyboard(context);
    setState(() {
      _isLoading = true;
    });

    // Simulate registration processing
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    Helpers.showSnackBar(
      context,
      isBengali
          ? 'যাচাইকরণ কোড আপনার জিমেইলে পাঠানো হচ্ছে...'
          : 'Sending verification code to your Gmail...',
    );

    // Target to show on OTP screen is strictly the user's Gmail
    final target = email;

    // Navigate to OTP Screen
    context.push(AppRouter.otp, extra: {
      'target': target,
    });
  }

  void _handleGoogleSignup() {
    final isBengali = AppLanguage.current;
    Helpers.showSnackBar(
      context,
      isBengali
          ? 'নিরাপদ গুগল ভেরিফিকেশন চালু হচ্ছে...'
          : 'Opening Google Sign-Up...',
    );
  }

  void _handleLoginTap() {
    context.go(AppRouter.login);
  }

  void _handleTerms() {
    final isBengali = AppLanguage.current;
    Helpers.showSnackBar(
      context,
      isBengali ? 'শর্তাবলী পেইজ' : 'Terms of Service',
    );
  }

  void _handlePrivacy() {
    final isBengali = AppLanguage.current;
    Helpers.showSnackBar(
      context,
      isBengali ? 'গোপনীয়তা নীতি পেইজ' : 'Privacy Policy',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, _) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo, Title, P2P Trust, Tagline (Back button only)
                  SignupHeroSection(isBengali: isBengali),

                  const SizedBox(height: 14),

                  // Main Signup Card
                  SignupCard(
                    isBengali: isBengali,
                    isLoading: _isLoading,
                    onSignup: _handleSignup,
                    onLoginTap: _handleLoginTap,
                    onTermsTap: _handleTerms,
                    onPrivacyTap: _handlePrivacy,
                  ),

                  const SizedBox(height: 18),

                  // Social Signup Section (Divider + Google Sign-Up Button)
                  SignupSocialSection(
                    isBengali: isBengali,
                    onGoogleSignup: _handleGoogleSignup,
                  ),

                  const SizedBox(height: 20),

                  // Trust & Security Footnote
                  SignupTrustFootnote(isBengali: isBengali),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
