import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/router/app_router.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';
import 'widgets/otp_pin_input.dart';

class OtpScreen extends StatefulWidget {
  final String target;
  final bool isResetPassword;

  const OtpScreen({
    super.key,
    this.target = 'sujon.ahmed@gmail.com',
    this.isResetPassword = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _enteredCode = '';
  bool _isLoading = false;
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    final isBengali = AppLanguage.current;
    Helpers.hideKeyboard(context);
    if (_enteredCode.length < 6) {
      Helpers.showSnackBar(
        context,
        isBengali
            ? 'দয়া করে সম্পূর্ণ ৬ সংখ্যার ওটিপি কোড দিন'
            : 'Please enter the complete 6-digit OTP code',
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate OTP verification delay
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (widget.isResetPassword) {
      Helpers.showSnackBar(
        context,
        isBengali
            ? 'ওটিপি সফল! নতুন পাসওয়ার্ড সেট করুন।'
            : 'OTP verified! Set your new password.',
      );
      // Navigate to Reset Password Screen
      context.pushReplacement(AppRouter.resetPassword, extra: {
        'email': widget.target,
      });
    } else {
      Helpers.showSnackBar(
        context,
        isBengali
            ? 'অভিনন্দন! আপনার ওটিপি সফলভাবে যাচাই হয়েছে।'
            : 'Congratulations! OTP verified successfully.',
      );
      // Navigate to Profile Setup / Account Registration
      context.pushReplacement(AppRouter.profileSetup, extra: {
        'email': widget.target,
      });
    }
  }

  void _handleResend() {
    final isBengali = AppLanguage.current;
    if (_secondsRemaining > 0) return;
    _startTimer();
    Helpers.showSnackBar(
      context,
      isBengali
          ? 'আপনার জিমেইলে নতুন ওটিপি কোড পাঠানো হয়েছে (১২৩৪৫৬)'
          : 'New OTP code sent to your Gmail (123456)',
    );
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  // SMS / Email Icon Container
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withValues(
                            alpha: 0.15,
                          ),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.mark_email_read_outlined,
                        size: 36,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    isBengali ? 'ওটিপি যাচাইকরণ' : 'OTP Verification',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    isBengali
                        ? 'আপনার জিমেইল অ্যাকাউন্টে একটি ৬-সংখ্যার যাচাইকরণ কোড পাঠানো হয়েছে'
                        : 'A 6-digit verification code has been sent to your Gmail',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Destination Target Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.target,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 6-Pin Input Boxes
                  OtpPinInput(
                    length: 6,
                    onChanged: (code) {
                      setState(() {
                        _enteredCode = code;
                      });
                    },
                    onCompleted: (code) {
                      setState(() {
                        _enteredCode = code;
                      });
                      _handleVerify();
                    },
                  ),

                  const SizedBox(height: 24),

                  // Resend Timer Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isBengali ? 'কোড পাননি? ' : "Didn't receive code? ",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: _secondsRemaining == 0 ? _handleResend : null,
                        child: Text(
                          _secondsRemaining > 0
                              ? '${isBengali ? 'পুনরায় পাঠান' : 'Resend in'} (00:${_secondsRemaining.toString().padLeft(2, '0')})'
                              : (isBengali
                                    ? 'পুনরায় কোড পাঠান'
                                    : 'Resend Code'),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _secondsRemaining == 0
                                ? AppColors.primaryContainer
                                : AppColors.outline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleVerify,
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
                                  Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isBengali
                                      ? 'যাচাই ও সম্পন্ন করুন'
                                      : 'Verify & Proceed',
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

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
