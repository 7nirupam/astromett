import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/primary_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  DateTime? _selectedDate;
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _submittedEmail;
  String? _reservationId;

  // Track already registered emails locally to prevent duplicate submissions
  final Set<String> _registeredEmails = {};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    // Mature matchmaking platform: minimum 18 years old
    final now = DateTime.now();
    final adultMaxDate = DateTime(now.year - 18, now.month, now.day);
    final initialDate = DateTime(now.year - 26, now.month, now.day);
    final firstDate = DateTime(now.year - 90);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? initialDate,
      firstDate: firstDate,
      lastDate: adultMaxDate,
      helpText: 'SELECT YOUR DATE OF BIRTH',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.champagneGold,
              onPrimary: AppColors.midnightNavy,
              surface: AppColors.deepCosmicPurple,
              onSurface: AppColors.warmIvory,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.midnightNavy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.antiqueGold, width: 1),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('MMMM d, yyyy').format(pickedDate);
      });
      _formKey.currentState?.validate();
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim().toLowerCase();

    // Check duplicate
    if (_registeredEmails.contains(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.royalPlum,
          content: Text(
            'This email has already been registered for Early Access.',
            style: AppTypography.bodySmall.copyWith(color: AppColors.warmIvory),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network submission call
    await Future.delayed(const Duration(milliseconds: 1400));

    if (!mounted) return;

    final id = 'ASTRO-${(1000 + DateTime.now().millisecondsSinceEpoch % 9000)}';
    _registeredEmails.add(email);

    setState(() {
      _isLoading = false;
      _isSuccess = true;
      _submittedEmail = email;
      _reservationId = id;
    });
  }

  void _resetForm() {
    setState(() {
      _isSuccess = false;
      _nameController.clear();
      _emailController.clear();
      _dobController.clear();
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return _buildSuccessCard();
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // First Name
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            style: AppTypography.bodyLarge.copyWith(color: AppColors.warmIvory),
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your given name',
              prefixIcon: Icon(
                Icons.person_outline,
                color: AppColors.champagneGold,
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your first name';
              }
              if (value.trim().length < 2) {
                return 'Name must be at least 2 characters';
              }
              if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value.trim())) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Email Address
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTypography.bodyLarge.copyWith(color: AppColors.warmIvory),
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'name@example.com',
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.champagneGold,
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }
              final emailRegex = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Date of Birth
          TextFormField(
            controller: _dobController,
            readOnly: true,
            onTap: _selectDateOfBirth,
            style: AppTypography.bodyLarge.copyWith(color: AppColors.warmIvory),
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              hintText: 'Select your birth date',
              prefixIcon: const Icon(
                Icons.cake_outlined,
                color: AppColors.champagneGold,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  color: AppColors.champagneGold,
                ),
                onPressed: _selectDateOfBirth,
              ),
            ),
            validator: (value) {
              if (_selectedDate == null || value == null || value.isEmpty) {
                return 'Please select your birth date for astrological chart analysis';
              }
              final now = DateTime.now();
              final age = now.year -
                  _selectedDate!.year -
                  ((now.month > _selectedDate!.month ||
                          (now.month == _selectedDate!.month &&
                              now.day >= _selectedDate!.day))
                      ? 0
                      : 1);
              if (age < 18) {
                return 'Astromett is designed for adults (18+ years)';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),

          // Submit CTA
          PrimaryButton(
            text: 'Reserve My Spot',
            onPressed: _handleSubmit,
            isLoading: _isLoading,
            icon: Icons.auto_awesome,
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          const SizedBox(height: 20),

          // Privacy Assurance
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.verified_outlined,
                size: 15,
                color: AppColors.antiqueGold,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppConstants.privacyNote,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.mutedLavender.withValues(alpha: 0.8),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.midnightNavy.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.champagneGold,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.champagneGold.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.success, width: 2),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.success,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your Spot Is Reserved',
            textAlign: TextAlign.center,
            style: AppTypography.cardHeading.copyWith(
              fontSize: 26,
              color: AppColors.champagneGold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.deepCosmicPurple,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.antiqueGold.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              'Reservation Code: $_reservationId',
              style: AppTypography.eyebrow.copyWith(
                color: AppColors.warmIvory,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A confirmation invitation has been assigned to ${_submittedEmail ?? 'your email'}. We will notify you with priority access as soon as our private cohort opens.',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.softIvory,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            text: 'Register Another Profile',
            variant: ButtonVariant.secondary,
            onPressed: _resetForm,
          ),
        ],
      ),
    );
  }
}

