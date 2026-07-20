import 'package:flutter/material.dart';

/// Palette de couleurs AODI, extraite des maquettes.
class AppColors {
  AppColors._();

  // Violet principal (boutons, onglet actif, FAB, liens)
  static const Color primary = Color(0xFF5B21D7);
  static const Color primaryDark = Color(0xFF3D0AD3);
  static const Color primaryLight = Color(0xFF8B5CF6);

  // Dégradé des cartes "hero" (prochain rendez-vous, etc.)
  static const Color gradientStart = Color(0xFFC65FDA);
  static const Color gradientMid = Color(0xFF7B2FF7);
  static const Color gradientEnd = Color(0xFF120B5E);

  // Fond & surfaces
  static const Color background = Color(0xFFF7F6FC);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF1EEFB);
  static const Color border = Color(0xFFE7E3F5);

  // Texte
  static const Color textDark = Color(0xFF1A1533);
  static const Color textBody = Color(0xFF5B5770);
  static const Color textMuted = Color(0xFF9A96AC);

  // Accents fonctionnels
  static const Color success = Color(0xFF22A45D);
  static const Color successBg = Color(0xFFE3F7EB);
  static const Color warning = Color(0xFFF97316);
  static const Color warningBg = Color(0xFFFEF0E4);
  static const Color danger = Color(0xFFE0245E);
  static const Color dangerBg = Color(0xFFFCE8ED);
  static const Color info = Color(0xFF2563EB);
  static const Color infoBg = Color(0xFFE7EEFD);
  static const Color teal = Color(0xFF0EA5A5);
  static const Color tealBg = Color(0xFFE1F5F5);
  static const Color pink = Color(0xFFDB2777);
  static const Color pinkBg = Color(0xFFFCE4F0);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientMid, gradientEnd],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF6D28F5), primary],
  );
}
