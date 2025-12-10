import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/common/notifications_modal.dart';
import '../../widgets/cards/balance_card.dart';
import '../../widgets/cards/stat_card.dart';
import '../../widgets/cards/action_card.dart';
import '../../widgets/cards/transaction_card.dart';
import '../transactions/add_money_screen.dart';
import '../transactions/send_money_screen.dart';
import '../transactions/withdraw_money_screen.dart';

/// Écran d'accueil moderne avec interface élégante
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.primaryLight.withValues(alpha: 0.03),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // AppBar
              SliverToBoxAdapter(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: _buildAppBar(context),
                ),
              ),

              // Contenu
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Carte de solde
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: BalanceCard(
                          balance: '5,420.50 €',
                          accountName: 'Compte principal',
                          accountNumber: '**** 1234',
                          isVisible: _isBalanceVisible,
                          onEyeTap: () {
                            setState(() => _isBalanceVisible = !_isBalanceVisible);
                          },
                          onAddTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                            );
                          },
                          onSendTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SendMoneyScreen()),
                            );
                          },
                          onWithdrawTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const WithdrawMoneyScreen()),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Statistiques
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Iconsax.wallet_add,
                                title: 'Revenus',
                                value: '3,240 €',
                                subtitle: '+12% ce mois',
                                color: AppColors.success,
                                onTap: () => _showComingSoon('Revenus'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: StatCard(
                                icon: Iconsax.wallet_minus,
                                title: 'Dépenses',
                                value: '1,820 €',
                                subtitle: '-8% ce mois',
                                color: AppColors.error,
                                onTap: () => _showComingSoon('Dépenses'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Actions rapides
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Actions rapides',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ActionCard(
                              icon: Iconsax.send_2,
                              title: 'Envoyer de l\'argent',
                              subtitle: 'Transfert instantané',
                              color: AppColors.primary,
                              onTap: () => _showComingSoon('Envoyer argent'),
                            ),
                            const SizedBox(height: 12),
                            ActionCard(
                              icon: Iconsax.card_pos,
                              title: 'Payer une facture',
                              subtitle: 'Électricité, eau, téléphone',
                              color: AppColors.info,
                              onTap: () => _showComingSoon('Payer facture'),
                            ),
                            const SizedBox(height: 12),
                            ActionCard(
                              icon: Iconsax.chart_square,
                              title: 'Statistiques détaillées',
                              subtitle: 'Voir vos dépenses',
                              color: AppColors.accent,
                              onTap: () => _showComingSoon('Statistiques'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Transactions récentes
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Transactions récentes',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _showComingSoon('Toutes les transactions'),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                  child: const Text(
                                    'Voir tout',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TransactionCard(
                              icon: Iconsax.wallet_check,
                              title: 'Salaire reçu',
                              subtitle: 'Aujourd\'hui, 10:30',
                              amount: '2,500 €',
                              isPositive: true,
                              onTap: () => _showComingSoon('Détails transaction'),
                            ),
                            const SizedBox(height: 12),
                            TransactionCard(
                              icon: Iconsax.shopping_cart,
                              title: 'Supermarché',
                              subtitle: 'Hier, 18:45',
                              amount: '85.50 €',
                              isPositive: false,
                              iconColor: AppColors.primary,
                              onTap: () => _showComingSoon('Détails transaction'),
                            ),
                            const SizedBox(height: 12),
                            TransactionCard(
                              icon: Iconsax.electricity,
                              title: 'Facture électricité',
                              subtitle: 'Il y a 2 jours',
                              amount: '120 €',
                              isPositive: false,
                              iconColor: AppColors.warning,
                              onTap: () => _showComingSoon('Détails transaction'),
                            ),
                            const SizedBox(height: 12),
                            TransactionCard(
                              icon: Iconsax.money_recive,
                              title: 'Remboursement',
                              subtitle: 'Il y a 3 jours',
                              amount: '45 €',
                              isPositive: true,
                              onTap: () => _showComingSoon('Détails transaction'),
                            ),
                          ],
                        ),
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu burger
          Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Iconsax.menu, color: AppColors.primary),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              );
            },
          ),

          // Titre et sous-titre
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour,',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notifications
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Iconsax.notification, color: AppColors.primary),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const NotificationsModal(),
                    );
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
}
