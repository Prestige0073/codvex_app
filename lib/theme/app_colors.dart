import 'package:flutter/material.dart';

/// Palette de couleurs professionnelle pour CodVex
/// Thème bleu élégant et moderne
class AppColors {
  // Couleurs principales - Bleu professionnel
  static const Color primary = Color(0xFF1E3A8A); // Bleu profond corporate
  static const Color primaryLight = Color(0xFF3B82F6); // Bleu vif moderne
  static const Color primaryDark = Color(0xFF1E40AF); // Bleu très foncé

  // Couleurs d'accent
  static const Color accent = Color(0xFF60A5FA); // Bleu clair pour highlights
  static const Color accentLight = Color(0xFF93C5FD); // Bleu très clair

  // Couleurs de fond
  static const Color background = Color(0xFFF8FAFC); // Gris très clair
  static const Color surface = Color(0xFFFFFFFF); // Blanc pur
  static const Color surfaceLight = Color(0xFFF1F5F9); // Gris ultra clair

  // Couleurs de texte
  static const Color textPrimary = Color(0xFF1E293B); // Gris très foncé
  static const Color textSecondary = Color(0xFF64748B); // Gris moyen
  static const Color textTertiary = Color(0xFF94A3B8); // Gris clair
  static const Color textWhite = Color(0xFFFFFFFF); // Blanc

  // Couleurs de statut
  static const Color success = Color(0xFF10B981); // Vert succès
  static const Color successLight = Color(0xFFD1FAE5); // Vert clair
  static const Color error = Color(0xFFEF4444); // Rouge erreur
  static const Color errorLight = Color(0xFFFEE2E2); // Rouge clair
  static const Color warning = Color(0xFFF59E0B); // Orange avertissement
  static const Color warningLight = Color(0xFFFEF3C7); // Orange clair
  static const Color info = Color(0xFF3B82F6); // Bleu info
  static const Color infoLight = Color(0xFFDDEAFE); // Bleu clair

  // Couleurs pour les bordures et dividers
  static const Color border = Color(0xFFCBD5E1); // Gris bordure (plus visible)
  static const Color borderLight = Color(0xFFE2E8F0); // Gris bordure claire
  static const Color divider = Color(0xFFCBD5E1); // Gris divider

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, accent],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, Color(0xFF0EA5E9)], // Du bleu profond au cyan
  );

  // Ombres
  static BoxShadow get cardShadow => BoxShadow(
    color: primary.withValues(alpha: 0.08),
    blurRadius: 24,
    offset: const Offset(0, 8),
    spreadRadius: 0,
  );

  static BoxShadow get buttonShadow => BoxShadow(
    color: primary.withValues(alpha: 0.3),
    blurRadius: 12,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primary.withValues(alpha: 0.05),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];
}
