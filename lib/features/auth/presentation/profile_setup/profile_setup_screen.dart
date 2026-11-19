import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/router/app_router.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String email;

  const ProfileSetupScreen({super.key, this.email = 'sujon.ahmed@gmail.com'});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _referralController;

  String _selectedRole = 'both'; // 'buyer', 'both', 'seller'
  bool _isLoading = false;
  bool _isReferralApplied = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'সুজন আহমেদ');
    _locationController = TextEditingController(
      text: 'মিরপুর ১০, ঢাকা (Mirpur 10, Dhaka)',
    );
    _referralController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _applyReferral() {
    final code = _referralController.text.trim();
    final isBengali = AppLanguage.current;
    if (code.isEmpty) {
      Helpers.showSnackBar(
        context,
        isBengali ? 'রেফারেল কোড লিখুন' : 'Enter referral code',
        isError: true,
      );
      return;
    }
    setState(() {
      _isReferralApplied = true;
    });
    Helpers.showSnackBar(
      context,
      isBengali
          ? 'রেফারেল কোড "$code" গৃহীত হয়েছে! ১০০ পয়েন্ট বোনাস যোগ হয়েছে।'
          : 'Referral code "$code" applied! 100 bonus points credited.',
    );
  }

  Future<void> _handleSubmit() async {
    Helpers.hideKeyboard(context);
    final isBengali = AppLanguage.current;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate saving profile data
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    Helpers.showSnackBar(
      context,
      isBengali
          ? 'স্বাগতম! আপনার প্রোফাইল সফলভাবে তৈরি হয়েছে।'
          : 'Welcome! Your profile has been created successfully.',
    );

    // Navigate to Home Screen
    context.go(AppRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, _) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 24),
              color: AppColors.onSurface,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRouter.login);
                }
              },
            ),
            title: Text(
              isBengali ? 'অ্যাকাউন্ট রেজিস্ট্রেশন' : 'Account Registration',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
            centerTitle: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Step Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isBengali ? 'আপনার প্রোফাইল' : 'Your Profile',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          isBengali ? '১০০% সম্পন্ন' : '100% Completed',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Header Info / Encouraging Notice Card
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.surfaceContainerHighest.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryFixed,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_user_rounded,
                              size: 18,
                              color: AppColors.onPrimaryFixedVariant,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBengali
                                      ? 'পরিচিতি তৈরি করুন'
                                      : 'Build Your Profile',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isBengali
                                      ? 'একটি সম্পূর্ণ প্রোফাইল দ্রুত লেনদেন এবং নিরাপদ বাণিজ্যে সহায়তা করে।'
                                      : 'A complete profile assists in fast deals and secure marketplace trade.',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Avatar Upload Area
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surfaceContainerLow,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person_rounded,
                                              size: 56,
                                              color: AppColors.primaryContainer,
                                            ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Helpers.showSnackBar(
                                    context,
                                    isBengali
                                        ? 'ছবি আপলোড অপশন চালু হচ্ছে...'
                                        : 'Opening photo selector...',
                                  );
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.15,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.photo_camera_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isBengali
                                ? 'প্রোফাইল বা ব্যবসার ছবি দিন'
                                : 'Add profile or business photo',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Full Name Input
                    _buildInputLabel(
                      icon: Icons.person_rounded,
                      title: isBengali
                          ? 'সম্পূর্ণ নাম (Full Name)'
                          : 'Full Name',
                      isRequired: true,
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _nameController,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return isBengali
                              ? 'আপনার পুরো নাম দিন'
                              : 'Enter full name';
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
                        fillColor: AppColors.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        hintText: isBengali
                            ? 'যেমন: সুজন আহমেদ'
                            : 'e.g. Sujon Ahmed',
                        suffixIcon: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primaryContainer,
                          size: 20,
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
                    const SizedBox(height: 4),
                    Text(
                      isBengali
                          ? 'জাতীয় পরিচয়পত্র বা ব্যবসায়িক ট্রেডলাইসেন্সের নাম ব্যবহার করুন'
                          : 'Use your name matching NID or trade license',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Location Input (Pure Text Field - No Suggestions)
                    _buildInputLabel(
                      icon: Icons.location_on_rounded,
                      title: isBengali
                          ? 'শহর / এলাকা লিখুন (Location)'
                          : 'City / Area (Location)',
                      isRequired: true,
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _locationController,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return isBengali
                              ? 'আপনার শহর বা এলাকা লিখুন'
                              : 'Please type your area or city';
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
                        fillColor: AppColors.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        hintText: isBengali
                            ? 'যেমন: মিরপুর ১০, ঢাকা'
                            : 'e.g. Mirpur 10, Dhaka',
                        hintStyle: TextStyle(
                          color: AppColors.outline.withValues(alpha: 0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        suffixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primaryContainer,
                          size: 20,
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
                    const SizedBox(height: 4),
                    Text(
                      isBengali
                          ? 'আপনার নিজস্ব এলাকা, থানা বা শহরের নাম সরাসরি টাইপ করে লিখুন'
                          : 'Type your specific area, thana, or city directly',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Role Selector
                    _buildInputLabel(
                      icon: Icons.sync_alt_rounded,
                      title: isBengali
                          ? 'আপনার ভূমিকা (Role Selection)'
                          : 'Your Role Selection',
                      isRequired: true,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _buildRoleButton(
                            roleId: 'buyer',
                            title: isBengali ? 'ক্রেতা' : 'Buyer',
                          ),
                          _buildRoleButton(
                            roleId: 'both',
                            title: isBengali ? 'উভয়ই' : 'Both',
                          ),
                          _buildRoleButton(
                            roleId: 'seller',
                            title: isBengali ? 'বিক্রেতা' : 'Seller',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Active Role Hint Badge
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getRoleIcon(_selectedRole),
                            color: AppColors.primaryContainer,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _getRoleHint(_selectedRole, isBengali),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.onSurface,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Referral Code Input (Optional)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInputLabel(
                          icon: Icons.card_giftcard_rounded,
                          title: isBengali
                              ? 'রেফারেল কোড (Referral Code)'
                              : 'Referral Code',
                          isRequired: false,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isBengali ? 'ঐচ্ছিক' : 'Optional',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _referralController,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: AppColors.onSurface,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.surfaceContainerLowest,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              hintText: isBengali
                                  ? 'যেমন: BAZAR2025'
                                  : 'e.g. BAZAR2025',
                              hintStyle: TextStyle(
                                color: AppColors.outline.withValues(alpha: 0.4),
                                letterSpacing: 0,
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
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _isReferralApplied ? null : _applyReferral,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _isReferralApplied
                                ? (isBengali ? 'প্রযুক্ত' : 'Applied')
                                : (isBengali ? 'প্রয়োগ' : 'Apply'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _isReferralApplied
                                  ? AppColors.primaryContainer
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Trust Footnote Card
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryFixed.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.shield_rounded,
                            size: 22,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: isBengali
                                        ? 'নিরাপত্তা ও বিশ্বাস: '
                                        : 'Safety & Trust: ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: isBengali
                                        ? 'সঠিক তথ্য দিলে ক্রেতা ও বিক্রেতাদের আস্থা বাড়ে এবং আপনার তালিকাভুক্ত পণ্য দ্রুত অনুমোদিত হয়।'
                                        : 'Providing accurate info builds peer trust and speeds up listing approval.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Primary Action Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: AppColors.primary.withValues(
                            alpha: 0.6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                                        ? 'সংরক্ষণ করুন ও মার্কেটপ্লেসে যান'
                                        : 'Save & Go to Marketplace',
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

                    const SizedBox(height: 8),

                    // Helper caption
                    Text(
                      isBengali
                          ? 'সরাসরি মার্কেটপ্লেসে প্রবেশ করুন ও কেনাবেচা শুরু করুন'
                          : 'Directly enter the marketplace and start trading',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputLabel({
    required IconData icon,
    required String title,
    required bool isRequired,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
      ],
    );
  }

  Widget _buildRoleButton({required String roleId, required String title}) {
    final isSelected = _selectedRole == roleId;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedRole = roleId;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 38,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'buyer':
        return Icons.shopping_bag_rounded;
      case 'seller':
        return Icons.storefront_rounded;
      case 'both':
      default:
        return Icons.swap_horizontal_circle_rounded;
    }
  }

  String _getRoleHint(String role, bool isBengali) {
    switch (role) {
      case 'buyer':
        return isBengali
            ? 'আপনি যাচাইকৃত বিক্রেতাদের থেকে পণ্য কিনতে এবং সরাসরি অফার পাঠাতে পারবেন।'
            : 'You can buy from verified sellers and send direct price offers.';
      case 'seller':
        return isBengali
            ? 'আপনি ফ্রি পণ্য লিস্টিং ও লোকাল ক্রেতাদের সাথে সরাসরি চ্যাট করতে পারবেন।'
            : 'You can list items for free and chat directly with local buyers.';
      case 'both':
      default:
        return isBengali
            ? 'আপনি পণ্য কেনাকাটা এবং নিজের পণ্য সরাসরি বিক্রি—উভয় সুবিধাই উপভোগ করতে পারবেন।'
            : 'You can enjoy both buying products and selling your own items directly.';
    }
  }
}
