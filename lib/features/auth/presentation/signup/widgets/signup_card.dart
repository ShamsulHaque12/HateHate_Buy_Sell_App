import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'password_strength_bar.dart';

class SignupCard extends StatefulWidget {
  final bool isBengali;
  final bool isLoading;
  final Future<void> Function({
    required String email,
    required String phone,
    required String password,
  })
  onSignup;
  final VoidCallback onLoginTap;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const SignupCard({
    super.key,
    required this.isBengali,
    required this.isLoading,
    required this.onSignup,
    required this.onLoginTap,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'sujon.ahmed@gmail.com');
    _phoneController = TextEditingController(text: '০১৭১২-৩৪৫৬৭৮');
    _passwordController = TextEditingController(text: 'Sujon@786#');
    _confirmPasswordController = TextEditingController(text: 'Sujon@786#');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isPasswordMatch {
    final pass = _passwordController.text;
    final confirm = _confirmPasswordController.text;
    return pass.isNotEmpty && pass == confirm;
  }

  Future<void> _handleSubmit() async {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isBengali
                ? 'দয়া করে শর্তাবলী ও গোপনীয়তা নীতি মেনে নিন'
                : 'Please agree to the Terms and Privacy Policy',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      await widget.onSignup(
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(18.0),
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
            // Email Input
            _buildLabel(
              icon: Icons.mail_outline,
              label: widget.isBengali
                  ? 'ইমেইল বা জিমেইল অ্যাড্রেস'
                  : 'Email Address',
              isRequired: true,
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return widget.isBengali ? 'ইমেইল দিন' : 'Enter email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(v.trim())) {
                  return widget.isBengali
                      ? 'সঠিক ইমেইল ফরম্যাট দিন'
                      : 'Valid email required';
                }
                return null;
              },
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              decoration: _inputDecoration(
                hint: 'sujon.ahmed@gmail.com',
                prefixIcon: Icons.mail_outline,
              ),
            ),

            const SizedBox(height: 14),

            // Mobile Number (Optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel(
                  icon: Icons.phone_android_outlined,
                  label: widget.isBengali
                      ? 'মোবাইল নম্বর (এসএমএস ও ওটিপি)'
                      : 'Mobile Number (SMS & OTP)',
                  isRequired: false,
                ),
                Text(
                  widget.isBengali ? 'ঐচ্ছিক' : 'Optional',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                // BD Dial Code Pill
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text('🇧🇩', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        widget.isBengali ? '+৮৮০' : '+880',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Phone field
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      hintText: widget.isBengali
                          ? '০১৭১২-৩৪৫৬৭৮'
                          : '01712-345678',
                      hintStyle: TextStyle(
                        color: AppColors.outline.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primaryContainer,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Password Input with Strength Meter
            _buildLabel(
              icon: Icons.lock_outline,
              label: widget.isBengali ? 'পাসওয়ার্ড' : 'Password',
              isRequired: true,
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              onChanged: (_) => setState(() {}),
              validator: (v) => v == null || v.length < 6
                  ? (widget.isBengali
                        ? 'কমপক্ষে ৬ ডিজিটের পাসওয়ার্ড দিন'
                        : 'Min 6 characters')
                  : null,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              decoration: _inputDecoration(
                hint: '••••••••',
                prefixIcon: Icons.lock_outline,
                suffix: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 19,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            // Strength Indicator
            PasswordStrengthBar(
              password: _passwordController.text,
              isBengali: widget.isBengali,
            ),

            const SizedBox(height: 14),

            // Confirm Password Input
            _buildLabel(
              icon: Icons.enhanced_encryption_outlined,
              label: widget.isBengali
                  ? 'পাসওয়ার্ড নিশ্চিত করুন'
                  : 'Confirm Password',
              isRequired: true,
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return widget.isBengali
                      ? 'পাসওয়ার্ড নিশ্চিত করুন'
                      : 'Confirm your password';
                }
                if (v != _passwordController.text) {
                  return widget.isBengali
                      ? 'পাসওয়ার্ড মিলছে না'
                      : 'Passwords do not match';
                }
                return null;
              },
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              decoration: _inputDecoration(
                hint: '••••••••',
                prefixIcon: Icons.enhanced_encryption_outlined,
                suffix: _isPasswordMatch
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primaryContainer,
                        size: 20,
                      )
                    : IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 19,
                          color: AppColors.onSurfaceVariant.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
              ),
            ),

            const SizedBox(height: 12),

            // Terms and Policies Checkbox
            GestureDetector(
              onTap: () {
                setState(() {
                  _agreeTerms = !_agreeTerms;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 2, right: 8),
                    decoration: BoxDecoration(
                      color: _agreeTerms
                          ? AppColors.primaryContainer
                          : AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: _agreeTerms
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          widget.isBengali
                              ? 'আমি হাতেহাতে-এর '
                              : 'I agree to HateHate\'s ',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant,
                            height: 1.3,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTermsTap,
                          child: Text(
                            widget.isBengali ? 'শর্তাবলী' : 'Terms of Service',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          widget.isBengali ? ' এবং ' : ' and ',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onPrivacyTap,
                          child: Text(
                            widget.isBengali
                                ? 'গোপনীয়তা নীতি'
                                : 'Privacy Policy',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          widget.isBengali ? ' মেনে নিচ্ছি।' : '.',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Primary Signup Action Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleSubmit,
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
                child: widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
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
                            widget.isBengali
                                ? 'অ্যাকাউন্ট তৈরি করুন'
                                : 'Create Account',
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

            const SizedBox(height: 12),

            // Already have account prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isBengali
                      ? 'ইতিমধ্যে অ্যাকাউন্ট আছে? '
                      : 'Already have an account? ',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onLoginTap,
                  child: Text(
                    widget.isBengali ? 'লগইন করুন' : 'Login',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel({
    required IconData icon,
    required String label,
    required bool isRequired,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.outline.withValues(alpha: 0.4),
        fontSize: 13,
      ),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primaryContainer,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}
