import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bogolan_pattern.dart';
import '../medical_record/medical_record_screen.dart';
import '../notifications/notifications_screen.dart';
import '../health_journey/health_journey_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 110),
          children: [
            Row(
              children: [
                const Expanded(child: Text('Profil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark))),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.notifications_none_rounded, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.settings_outlined, color: AppColors.textDark),
              ],
            ),
            const SizedBox(height: 16),
            _ProfileCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                _statCard('28 ans', 'Âge', Icons.cake_rounded),
                const SizedBox(width: 10),
                _statCard('+223 70 12 34 56', 'Téléphone', Icons.call_rounded, small: true),
                const SizedBox(width: 10),
                _statCard('B+', 'Groupe sanguin', Icons.bloodtype_rounded),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
              child: Column(
                children: [
                  _menuTile(Icons.person_outline_rounded, 'Informations personnelles', onTap: () {}),
                  _menuTile(Icons.credit_card_rounded, 'Carte médicale', trailing: 'NFC', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MedicalRecordScreen()))),
                  _menuTile(Icons.health_and_safety_outlined, 'Assurance santé', onTap: () {}),
                  _menuTile(Icons.route_rounded, 'Mon parcours de santé', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HealthJourneyScreen()))),
                  _menuTile(Icons.payments_outlined, 'Paiements & Abonnements', onTap: () {}),
                  _menuTile(Icons.description_outlined, 'Mes documents', onTap: () {}),
                  _menuTile(Icons.phone_in_talk_outlined, 'Contacts d\'urgence', onTap: () {}),
                  _menuTile(Icons.settings_outlined, 'Paramètres & Confidentialité', onTap: () {}),
                  _menuTile(Icons.language_rounded, 'Langue', trailing: 'Français', onTap: () {}, isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, side: const BorderSide(color: AppColors.dangerBg)),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text('Déconnexion'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon, {bool small = false}) {
    return Expanded(
      flex: small ? 2 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(height: 6),
            Text(value, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w800, fontSize: small ? 11.5 : 13, color: AppColors.textDark)),
            const SizedBox(height: 2),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(IconData icon, String label, {String? trailing, required VoidCallback onTap, bool isLast = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textBody, size: 19),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark))),
            if (trailing != null) Text(trailing, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(22)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            const Positioned.fill(child: BogolanPattern()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(radius: 42, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt_rounded, size: 14, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Astou Diallo', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text('Patient', style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 12.5)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                    child: const Text('ID : AODI-2025-00078', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
