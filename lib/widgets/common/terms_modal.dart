import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_colors.dart';

/// Modal réutilisable pour afficher les conditions d'utilisation
/// et la politique de confidentialité avec défilement obligatoire
class TermsModal extends StatefulWidget {
  const TermsModal({super.key});

  @override
  State<TermsModal> createState() => _TermsModalState();
}

class _TermsModalState extends State<TermsModal> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      // Vérifie si l'utilisateur a scrollé jusqu'en bas (avec une marge de 50px)
      if (currentScroll >= maxScroll - 50 && !_hasScrolledToBottom) {
        setState(() {
          _hasScrolledToBottom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Iconsax.document_text_1,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Conditions & Confidentialité',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.close_circle,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ),

            // Contenu avec scroll
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      'Conditions d\'utilisation',
                      [
                        '1. En utilisant CodVex, vous acceptez de respecter les présentes conditions d\'utilisation.',
                        '2. Vous devez être âgé d\'au moins 18 ans pour utiliser ce service.',
                        '3. Vous êtes responsable de maintenir la confidentialité de votre compte et mot de passe.',
                        '4. Vous acceptez de ne pas utiliser le service à des fins illégales ou non autorisées.',
                        '5. CodVex se réserve le droit de modifier ou interrompre le service à tout moment.',
                        '6. Vous reconnaissez que toutes les informations financières sont fournies à titre indicatif uniquement.',
                        '7. CodVex n\'est pas responsable des pertes financières découlant de l\'utilisation du service.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Politique de confidentialité',
                      [
                        '1. Collecte de données : Nous collectons uniquement les informations nécessaires au bon fonctionnement du service.',
                        '2. Utilisation des données : Vos données sont utilisées pour personnaliser votre expérience et améliorer nos services.',
                        '3. Protection : Nous mettons en œuvre des mesures de sécurité pour protéger vos informations personnelles.',
                        '4. Partage : Nous ne vendons ni ne louons vos informations personnelles à des tiers.',
                        '5. Cookies : Nous utilisons des cookies pour améliorer votre expérience utilisateur.',
                        '6. Droits : Vous avez le droit d\'accéder, modifier ou supprimer vos données personnelles.',
                        '7. Contact : Pour toute question concernant vos données, contactez-nous à privacy@codvex.com.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Sécurité et Responsabilités',
                      [
                        '1. Vous devez maintenir la sécurité de vos identifiants de connexion.',
                        '2. Signalez immédiatement toute utilisation non autorisée de votre compte.',
                        '3. CodVex utilise un cryptage SSL pour protéger vos données.',
                        '4. Nous effectuons des audits de sécurité réguliers.',
                        '5. Vous acceptez de ne pas tenter de pirater ou compromettre le système.',
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Indicateur de défilement
                    if (!_hasScrolledToBottom)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.warning.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.arrow_down_1,
                              color: AppColors.warning,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Veuillez faire défiler jusqu\'en bas pour accepter',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Footer avec boutons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                border: Border(
                  top: BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: AppColors.border,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Refuser',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _hasScrolledToBottom
                          ? () => Navigator.of(context).pop(true)
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            _hasScrolledToBottom ? AppColors.success : null,
                        disabledBackgroundColor:
                            AppColors.textTertiary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: _hasScrolledToBottom ? 2 : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_hasScrolledToBottom)
                            const Icon(
                              Iconsax.tick_circle5,
                              size: 20,
                              color: Colors.white,
                            ),
                          if (_hasScrolledToBottom) const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _hasScrolledToBottom ? 'J\'accepte' : 'Défiler pour accepter',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _hasScrolledToBottom
                                    ? Colors.white
                                    : AppColors.textTertiary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
