import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/terms_modal.dart';
import '../home/home_screen.dart';

/// Écran d'inscription simplifié et optimisé
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;

  // État de validation
  bool _hasMinLength = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
    _confirmPasswordController.addListener(_updatePasswordValidation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordValidation() {
    setState(() {
      _hasMinLength = _passwordController.text.length >= 8;
      _hasUpperCase = _passwordController.text.contains(RegExp(r'[A-Z]'));
      _hasNumber = _passwordController.text.contains(RegExp(r'[0-9]'));
      _passwordsMatch = _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom';
    }
    if (value.length < 3) {
      return 'Au moins 3 caractères';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (!_hasMinLength || !_hasUpperCase || !_hasNumber) {
      return 'Mot de passe non conforme';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmez votre mot de passe';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  Future<void> _showTermsModal() async {
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const TermsModal(),
    );

    if (accepted == true && mounted) {
      setState(() => _acceptTerms = true);
    } else if (accepted == false && mounted) {
      // Afficher un message si l'utilisateur refuse
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Iconsax.info_circle, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Vous devez accepter les conditions pour créer un compte',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
      setState(() => _acceptTerms = false);
    }
  }

  Future<void> _handleRegister() async {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Acceptez les conditions d\'utilisation'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.accentLight.withValues(alpha: 0.08),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Inscription',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Contenu
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icône illustrative
                          FadeInDown(
                            duration: const Duration(milliseconds: 600),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Iconsax.user_add,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Titre
                          FadeInDown(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 100),
                            child: const Text(
                              'Créer un compte',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          FadeInDown(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 200),
                            child: const Text(
                              'Rejoignez CodVex',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Nom
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 200),
                            child: CustomTextField(
                              controller: _nameController,
                              label: 'Nom complet',
                              hint: 'Jean Dupont',
                              prefixIcon: Iconsax.user,
                              validator: _validateName,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Email
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 300),
                            child: CustomTextField(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'exemple@email.com',
                              prefixIcon: Iconsax.sms,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Mot de passe
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 400),
                            child: CustomTextField(
                              controller: _passwordController,
                              label: 'Mot de passe',
                              hint: '••••••••',
                              prefixIcon: Iconsax.lock,
                              isPassword: true,
                              validator: _validatePassword,
                            ),
                          ),

                          // Critères du mot de passe
                          if (_passwordController.text.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            FadeInUp(
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _PasswordCriterion(
                                      text: '8 caractères minimum',
                                      isMet: _hasMinLength,
                                    ),
                                    const SizedBox(height: 6),
                                    _PasswordCriterion(
                                      text: 'Une majuscule',
                                      isMet: _hasUpperCase,
                                    ),
                                    const SizedBox(height: 6),
                                    _PasswordCriterion(
                                      text: 'Un chiffre',
                                      isMet: _hasNumber,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 16),

                          // Confirmation mot de passe
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: _confirmPasswordController,
                                  label: 'Confirmer le mot de passe',
                                  hint: '••••••••',
                                  prefixIcon: Iconsax.shield_tick,
                                  isPassword: true,
                                  validator: _validateConfirmPassword,
                                ),
                                // Indicateur de correspondance
                                if (_confirmPasswordController.text.isNotEmpty)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _passwordsMatch
                                              ? Iconsax.tick_circle5
                                              : Iconsax.close_circle5,
                                          size: 16,
                                          color: _passwordsMatch
                                              ? AppColors.success
                                              : AppColors.error,
                                        ),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            _passwordsMatch
                                                ? 'Les mots de passe correspondent'
                                                : 'Les mots de passe ne correspondent pas',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: _passwordsMatch
                                                  ? AppColors.success
                                                  : AppColors.error,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Checkbox conditions avec effet
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 600),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _acceptTerms
                                    ? AppColors.success.withValues(alpha: 0.05)
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _acceptTerms
                                      ? AppColors.success
                                      : AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(
                                      value: _acceptTerms,
                                      onChanged: (value) {
                                        if (value == true) {
                                          _showTermsModal();
                                        } else {
                                          setState(() => _acceptTerms = false);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      activeColor: AppColors.success,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _showTermsModal,
                                      child: Text.rich(
                                        TextSpan(
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                            height: 1.4,
                                          ),
                                          children: [
                                            const TextSpan(
                                                text: 'J\'accepte les '),
                                            TextSpan(
                                              text: 'Conditions',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            const TextSpan(text: ' et la '),
                                            TextSpan(
                                              text:
                                                  'Politique de confidentialité',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Bouton d'inscription avec icône
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 700),
                            child: CustomButton(
                              text: 'Créer mon compte',
                              onPressed: _handleRegister,
                              isLoading: _isLoading,
                              icon: Iconsax.user_add,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Lien vers connexion
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 800),
                            child: Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Déjà inscrit ? ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget pour afficher les critères du mot de passe
class _PasswordCriterion extends StatelessWidget {
  final String text;
  final bool isMet;

  const _PasswordCriterion({
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isMet ? Iconsax.tick_circle5 : Iconsax.close_circle5,
          size: 16,
          color: isMet ? AppColors.success : AppColors.textTertiary,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isMet ? AppColors.success : AppColors.textSecondary,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
