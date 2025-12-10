import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_colors.dart';

/// Carte de solde principal avec gradient
class BalanceCard extends StatelessWidget {
  final String balance;
  final String accountName;
  final String accountNumber;
  final VoidCallback? onEyeTap;
  final bool isVisible;
  final VoidCallback? onAddTap;
  final VoidCallback? onSendTap;
  final VoidCallback? onWithdrawTap;

  const BalanceCard({
    super.key,
    required this.balance,
    this.accountName = 'Compte principal',
    this.accountNumber = '**** 1234',
    this.onEyeTap,
    this.isVisible = true,
    this.onAddTap,
    this.onSendTap,
    this.onWithdrawTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec nom du compte
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountName,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    accountNumber,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onEyeTap,
                icon: Icon(
                  isVisible ? Iconsax.eye : Iconsax.eye_slash,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Solde
          Text(
            'Solde disponible',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isVisible ? balance : '••••••',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 20),

          // Actions rapides
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildQuickAction(
                  icon: Iconsax.add_circle,
                  label: 'Ajouter',
                  onTap: onAddTap ?? () {},
                ),
              ),
              Flexible(
                child: _buildQuickAction(
                  icon: Iconsax.send_2,
                  label: 'Envoyer',
                  onTap: onSendTap ?? () {},
                ),
              ),
              Flexible(
                child: _buildQuickAction(
                  icon: Iconsax.wallet_minus,
                  label: 'Retirer',
                  onTap: onWithdrawTap ?? () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
