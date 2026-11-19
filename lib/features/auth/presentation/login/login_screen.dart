import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/router/app_router.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';
import 'widgets/hero_brand_section.dart';
import 'widgets/login_card.dart';
import 'widgets/social_login_section.dart';
import 'widgets/top_utility_bar.dart';
import 'widgets/trust_legal_footer.dart';
import 'widgets/value_proposition_cards.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _handleLanguageChanged(bool isBengali) {
    AppLanguage.setLanguage(isBengali);
    Helpers.showSnackBar(
      context,
      isBengali ? 'বাংলা ভাষা নির্বাচন করা হয়েছে' : 'English selected',
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> _handleLogin(String email, String password) async {
    final isBengali = AppLanguage.current;
    Helpers.hideKeyboard(context);
    setState(() {
      _isLoading = true;
    });

    // Simulate authentication delay
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    Helpers.showSnackBar(
      context,
      isBengali ? 'লগইন সফল হয়েছে!' : 'Login successful!',
    );

    // Navigate to Home screen
    context.go(AppRouter.home);
  }

  void _handleGoogleLogin() {
    final isBengali = AppLanguage.current;
    Helpers.showSnackBar(
      context,
      isBengali
          ? 'নিরাপদ গুগল ভেরিফিকেশন চালু হচ্ছে...'
          : 'Initiating Google Sign-In...',
    );
  }

  void _handleForgotPassword() {
    final isBengali = AppLanguage.current;
    Helpers.showSnackBar(
      context,
      isBengali
          ? 'পাসওয়ার্ড রিসেট লিংক আপনার ইমেইলে পাঠানো হবে'
          : 'Password reset link will be sent to your email',
    );
  }

  void _handleRegister() {
    context.push(AppRouter.signup);
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
                  // Top Bar: 100% verified & Language Toggle (ONLY HERE)
                  TopUtilityBar(
                    isBengali: isBengali,
                    onLanguageChanged: _handleLanguageChanged,
                  ),

                  // Hero Identity (Logo, Title, P2P Trust, Tagline)
                  HeroBrandSection(isBengali: isBengali),

                  const SizedBox(height: 16),

                  // 2-Column Value Proposition Cards
                  ValuePropositionCards(isBengali: isBengali),

                  const SizedBox(height: 18),

                  // Email & Password Login Card
                  LoginCard(
                    isBengali: isBengali,
                    isLoading: _isLoading,
                    onLogin: _handleLogin,
                    onForgotPassword: _handleForgotPassword,
                    onRegister: _handleRegister,
                  ),

                  const SizedBox(height: 18),

                  // Social Login Section (Divider + Google Sign In)
                  SocialLoginSection(
                    isBengali: isBengali,
                    onGoogleLogin: _handleGoogleLogin,
                  ),

                  const SizedBox(height: 24),

                  // 256-bit Encryption & Legal Terms
                  TrustLegalFooter(
                    isBengali: isBengali,
                    onTermsTap: _handleTerms,
                    onPrivacyTap: _handlePrivacy,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
