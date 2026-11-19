import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class LoginCard extends StatefulWidget {
  final bool isBengali;
  final bool isLoading;
  final void Function(String email, String password) onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;

  const LoginCard({
    super.key,
    required this.isBengali,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onRegister,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'rahim.ahmed@gmail.com');
    _passwordController = TextEditingController(text: 'Secret@123');
    _checkEmailValidity(_emailController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLogin(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
            // Email Label Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 18,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.isBengali ? 'ইমেইল বা জিমেইল অ্যাড্রেস' : 'Email Address',
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
                Text(
                  'Gmail / Email',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.outline.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Email Input Box
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: _checkEmailValidity,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return widget.isBengali ? 'ইমেইল দিন' : 'Enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                  return widget.isBengali ? 'সঠিক ইমেইল ফরম্যাট দিন' : 'Enter a valid email';
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                  borderSide: const BorderSide(color: AppColors.primaryContainer, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Password Label Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 18,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.isBengali ? 'পাসওয়ার্ড' : 'Password',
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
                GestureDetector(
                  onTap: widget.onForgotPassword,
                  child: Text(
                    widget.isBengali ? 'পাসওয়ার্ড ভুলে গেছেন?' : 'Forgot password?',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Password Input Box
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return widget.isBengali ? 'পাসওয়ার্ড দিন' : 'Enter your password';
                }
                if (val.length < 6) {
                  return widget.isBengali ? 'কমপক্ষে ৬ ডিজিটের পাসওয়ার্ড দিন' : 'Minimum 6 characters';
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainerLow,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                hintText: '••••••••',
                hintStyle: TextStyle(
                  color: AppColors.outline.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: AppColors.outline,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryContainer, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Login Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.textLight,
                  disabledBackgroundColor: AppColors.primaryContainer.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.isBengali ? 'লগইন করুন' : 'Login',
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

            const SizedBox(height: 14),

            // Register Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isBengali ? 'অ্যাকাউন্ট নেই? ' : "Don't have an account? ",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onRegister,
                  child: Text(
                    widget.isBengali ? 'নতুন অ্যাকাউন্ট খুলুন' : 'Register Now',
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
    );
  }
}
