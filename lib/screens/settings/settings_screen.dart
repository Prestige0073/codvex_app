import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_colors.dart';

/// Page des paramètres de l'application
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = true;
  final bool _darkModeEnabled = false;

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
              AppColors.primaryLight.withValues(alpha: 0.05),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              _buildAppBar(context),

              // Contenu
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Compte
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        child: _buildSectionTitle('Compte'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: _buildSettingsCard([
                          _buildSettingItem(
                            icon: Iconsax.user_edit,
                            title: 'Modifier le profil',
                            subtitle: 'Nom, email, téléphone',
                            onTap: () => _showComingSoon('Modification profil'),
                          ),
                          _buildSettingItem(
                            icon: Iconsax.lock,
                            title: 'Changer le mot de passe',
                            subtitle: 'Sécurité du compte',
                            onTap: () => _showComingSoon('Changer mot de passe'),
                          ),
                          _buildSettingItem(
                            icon: Iconsax.shield_tick,
                            title: 'Authentification biométrique',
                            subtitle: 'Empreinte digitale / Face ID',
                            trailing: Switch(
                              value: _biometricEnabled,
                              onChanged: (value) {
                                setState(() => _biometricEnabled = value);
                              },
                              activeTrackColor: AppColors.success,
                            ),
                            onTap: null,
                          ),
                        ]),
                      ),

                      const SizedBox(height: 24),

                      // Section Notifications
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _buildSectionTitle('Notifications'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 300),
                        child: _buildSettingsCard([
                          _buildSettingItem(
                            icon: Iconsax.notification,
                            title: 'Activer les notifications',
                            subtitle: 'Recevoir des alertes',
                            trailing: Switch(
                              value: _notificationsEnabled,
                              onChanged: (value) {
                                setState(() => _notificationsEnabled = value);
                              },
                              activeTrackColor: AppColors.success,
                            ),
                            onTap: null,
                          ),
                          _buildSettingItem(
                            icon: Iconsax.sms_notification,
                            title: 'Notifications par email',
                            subtitle: 'Alertes importantes',
                            onTap: () => _showComingSoon('Notifications email'),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 24),

                      // Section Apparence
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: _buildSectionTitle('Apparence'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 500),
                        child: _buildSettingsCard([
                          _buildSettingItem(
                            icon: Iconsax.moon,
                            title: 'Mode sombre',
                            subtitle: 'Bientôt disponible',
                            trailing: Switch(
                              value: _darkModeEnabled,
                              onChanged: null,
                              activeTrackColor: AppColors.primary,
                            ),
                            onTap: null,
                          ),
                          _buildSettingItem(
                            icon: Iconsax.language_square,
                            title: 'Langue',
                            subtitle: 'Français',
                            onTap: () => _showComingSoon('Choix de langue'),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 24),

                      // Section Confidentialité
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                        child: _buildSectionTitle('Confidentialité et sécurité'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 700),
                        child: _buildSettingsCard([
                          _buildSettingItem(
                            icon: Iconsax.document_text,
                            title: 'Conditions d\'utilisation',
                            subtitle: 'Lire les CGU',
                            onTap: () => _showComingSoon('CGU'),
                          ),
                          _buildSettingItem(
                            icon: Iconsax.security_user,
                            title: 'Politique de confidentialité',
                            subtitle: 'Protection des données',
                            onTap: () =>
                                _showComingSoon('Politique confidentialité'),
                          ),
                          _buildSettingItem(
                            icon: Iconsax.trash,
                            title: 'Supprimer le compte',
                            subtitle: 'Action irréversible',
                            titleColor: AppColors.error,
                            onTap: () => _showDeleteAccountDialog(),
                            isLast: true,
                          ),
                        ]),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
            'Paramètres',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? titleColor,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (titleColor ?? AppColors.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: titleColor ?? AppColors.primary,
              size: 22,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: titleColor ?? AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          trailing: trailing ??
              (onTap != null
                  ? const Icon(
                      Iconsax.arrow_right_3,
                      size: 18,
                      color: AppColors.textSecondary,
                    )
                  : null),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 70,
            endIndent: 20,
          ),
      ],
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.info_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text('$feature - Bientôt disponible')),
          ],
        ),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Iconsax.warning_2,
                color: AppColors.error,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Supprimer le compte',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: const Text(
          'Cette action est irréversible. Toutes vos données seront définitivement supprimées.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showComingSoon('Suppression de compte');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
