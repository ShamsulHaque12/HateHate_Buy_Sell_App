import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/router/app_router.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _isLoading = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'sujon.ahmed@gmail.com');
    _checkEmailValidity(_emailController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _checkEmailValidity(String val) {
    final valid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim());
    if (valid != _isEmailValid) {
      setState(() {
        _isEmailValid = valid;
      });
    }
  }

  Future<void> _handleSendOtp() async {
    Helpers.hideKeyboard(context);
    final isBengali = AppLanguage.current;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate sending OTP delay
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    final email = _emailController.text.trim();

    Helpers.showSnackBar(
      context,
      isBengali
          ? 'আপনার জিমেইলে ওটিপি কোড পাঠানো হয়েছে!'
          : 'OTP code sent to your Gmail!',
    );

    // Navigate to OTP Screen with isResetPassword: true
    context.push(AppRouter.otp, extra: {
      'target': email,
      'isResetPassword': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, _) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: AppColors.onSurface,
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  // Elevated Icon Disc
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 38,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    isBengali ? 'পাসওয়ার্ড ভুলে গেছেন?' : 'Forgot Password?',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    isBengali
                        ? 'আপনার অ্যাকাউন্টের জিমেইল ঠিকানা দিন। আমরা সেখানে একটি ৬-সংখ্যার ওটিপি কোড পাঠাব।'
                        : 'Enter your account Gmail address. We will send a 6-digit OTP code to verify.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Main Card
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Label Header
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_outline,
                                size: 18,
                                color: AppColors.primaryContainer,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isBengali
                                    ? 'ইমেইল বা জিমেইল অ্যাড্রেস'
                                    : 'Gmail / Email Address',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const Text(
                                ' *',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.error,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Email Input Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: _checkEmailValidity,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return isBengali ? 'ইমেইল দিন' : 'Enter email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(val.trim())) {
                                return isBengali
                                    ? 'সঠিক ইমেইল ফরম্যাট দিন'
                                    : 'Valid email required';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurface,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              hintText: 'yourname@gmail.com',
                              hintStyle: TextStyle(
                                color: AppColors.outline.withValues(alpha: 0.5),
                                fontSize: 13,
                              ),
                              suffixIcon: _isEmailValid
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.primaryContainer,
                                      size: 20,
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryContainer, width: 2),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Send OTP Button
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryContainer,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: AppColors.primaryContainer
                                    .withValues(alpha: 0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          isBengali
                                              ? 'ওটিপি কোড পাঠান'
                                              : 'Send OTP Code',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Back to login prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isBengali
                                    ? 'পাসওয়ার্ড মনে পড়েছে? '
                                    : 'Remember your password? ',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.go(AppRouter.login),
                                child: Text(
                                  isBengali ? 'লগইন করুন' : 'Login',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Trust footnote
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_rounded,
                        size: 14,
                        color: AppColors.primaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isBengali
                            ? 'নিরাপদ ২৫৬-বিট এনক্রিপশনযুক্ত সুরক্ষা'
                            : 'Secure 256-bit SSL encrypted protection',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ],
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
