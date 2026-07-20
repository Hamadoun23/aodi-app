import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/section_header.dart';
import '../../widgets/bogolan_pattern.dart';
import '../../widgets/map_placeholder.dart';
import '../consultation/consultation_screen.dart';
import '../medical_record/medical_record_screen.dart';
import '../notifications/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 110),
          children: [
            _Header(onNotif: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                )),
            const SizedBox(height: 4),
            const Text(
              'Prenons soin de votre santé aujourd\'hui.',
              style: TextStyle(color: AppColors.textBody, fontSize: 13.5, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 14),
            const _LocationChip(),
            const SizedBox(height: 16),
            _SearchBar(onFilterTap: () {}),
            const SizedBox(height: 20),
            _NextAppointmentCard(
              onDetails: () => onNavigate(1),
              onJoin: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ConsultationScreen()),
              ),
            ),
            const SizedBox(height: 26),
            SectionHeader(title: 'Accès rapides', actionLabel: 'Voir tout', onAction: () {}),
            const SizedBox(height: 14),
            _QuickAccessGrid(onNavigate: onNavigate),
            const SizedBox(height: 22),
            _ConsultationBanner(onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ConsultationScreen()),
                )),
            const SizedBox(height: 14),
            _AssistantBanner(onTap: () {}),
            const SizedBox(height: 26),
            SectionHeader(title: 'Autour de vous', actionLabel: 'Voir sur la carte', onAction: () => onNavigate(2)),
            const SizedBox(height: 14),
            _NearbyPreview(onNavigate: onNavigate),
            const SizedBox(height: 26),
            SectionHeader(title: 'Activité récente', actionLabel: 'Voir tout', onAction: () {}),
            const SizedBox(height: 10),
            _ActivityTile(
              icon: Icons.science_rounded,
              color: AppColors.primary,
              bg: AppColors.surfaceMuted,
              title: 'Résultat d\'analyse disponible',
              subtitle: 'Analyse sanguine complète',
              time: 'Aujourd\'hui',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MedicalRecordScreen()),
              ),
            ),
            _ActivityTile(
              icon: Icons.description_rounded,
              color: AppColors.success,
              bg: AppColors.successBg,
              title: 'Ordonnance envoyée à la pharmacie',
              subtitle: '3 médicaments',
              time: 'Hier',
              onTap: () {},
            ),
            _ActivityTile(
              icon: Icons.credit_card_rounded,
              color: AppColors.info,
              bg: AppColors.infoBg,
              title: 'Paiement confirmé',
              subtitle: 'Consultation avec Dr Amadou Keïta',
              time: 'Hier',
              onTap: () {},
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onNotif;
  const _Header({required this.onNotif});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              children: [
                TextSpan(text: 'Bonjour Astou '),
                TextSpan(text: '👋'),
              ],
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onNotif,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded, color: AppColors.textDark, size: 26),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text('3',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
      ],
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Bamako, Mali  ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                  TextSpan(text: '· ACI 2000 · 0,8 km', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  const _SearchBar({required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.search_rounded, color: AppColors.textMuted),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Rechercher un médecin, une spécialité...',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13.5)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}

class _NextAppointmentCard extends StatelessWidget {
  final VoidCallback onDetails;
  final VoidCallback onJoin;
  const _NextAppointmentCard({required this.onDetails, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 12))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            const Positioned.fill(child: BogolanPattern()),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.event_available_rounded, color: Colors.white, size: 14),
                        SizedBox(width: 6),
                        Text('PROCHAIN RENDEZ-VOUS',
                            style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/avatar_amadou.png')),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Dr Amadou Keïta',
                                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 2),
                            const Text('Cardiologue', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.local_hospital_rounded, color: Colors.white70, size: 13),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text('Clinique AODI Bamako',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      const Text('Aujourd\'hui, 20 Mai', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time_rounded, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      const Text('15h30 · Vidéo', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onDetails,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white54),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                          ),
                          child: const Text('Voir le rendez-vous', style: TextStyle(fontSize: 12.5)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onJoin,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 13)),
                          icon: const Icon(Icons.videocam_rounded, size: 16),
                          label: const Text('Rejoindre', style: TextStyle(fontSize: 12.5)),
                        ),
                      ),
                    ],
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

class _QuickAccessGrid extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const _QuickAccessGrid({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final items = [
      (icon: Icons.medical_services_rounded, color: AppColors.primary, bg: AppColors.surfaceMuted, label: 'Médecins', sub: 'Consulter'),
      (icon: Icons.local_pharmacy_rounded, color: AppColors.success, bg: AppColors.successBg, label: 'Pharmacies', sub: 'Trouver'),
      (icon: Icons.science_rounded, color: AppColors.warning, bg: AppColors.warningBg, label: 'Laboratoires', sub: 'Analyses'),
      (icon: Icons.folder_shared_rounded, color: AppColors.info, bg: AppColors.infoBg, label: 'Dossier médical', sub: 'Consulter'),
      (icon: Icons.event_note_rounded, color: AppColors.pink, bg: AppColors.pinkBg, label: 'Rendez-vous', sub: 'Planifier'),
      (icon: Icons.videocam_rounded, color: AppColors.teal, bg: AppColors.tealBg, label: 'Consultation', sub: 'En ligne'),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.92,
      children: items.map((it) {
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            if (it.label == 'Rendez-vous') onNavigate(1);
            if (it.label == 'Dossier médical') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MedicalRecordScreen()));
            }
            if (it.label == 'Consultation') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConsultationScreen()));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: it.bg, borderRadius: BorderRadius.circular(14)),
                  child: Icon(it.icon, color: it.color, size: 20),
                ),
                const SizedBox(height: 8),
                Text(it.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                Text(it.sub, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ConsultationBanner extends StatelessWidget {
  final VoidCallback onTap;
  const _ConsultationBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/nurse_banner.png', width: 62, height: 74, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('CONSULTATION EN LIGNE', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                const SizedBox(height: 4),
                const Text('Parlez à un médecin sans vous déplacer', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14), textStyle: const TextStyle(fontSize: 12)),
                  child: const Text('Consulter maintenant'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantBanner extends StatelessWidget {
  final VoidCallback onTap;
  const _AssistantBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.08), AppColors.primaryLight.withValues(alpha: 0.12)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/robot_mascot.png', width: 56, height: 56),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('AODI Assistant IA', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textDark)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                      child: const Text('BETA', style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('Votre assistant santé 24h/7j à votre écoute', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14), textStyle: const TextStyle(fontSize: 12)),
                  child: const Text('Discuter maintenant'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbyPreview extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const _NearbyPreview({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final places = [
      (icon: Icons.local_hospital_rounded, color: AppColors.info, name: 'Clinique AODI Bamako', dist: '0,5 km'),
      (icon: Icons.local_pharmacy_rounded, color: AppColors.success, name: 'Pharmacie ACI 2000', dist: '0,6 km'),
      (icon: Icons.science_rounded, color: AppColors.warning, name: 'Laboratoire Santé+', dist: '1,2 km'),
    ];
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => onNavigate(2),
          child: const MapPlaceholder(height: 140),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
          child: Column(
            children: places.map((p) {
              final isLast = p == places.last;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border))),
                child: Row(
                  children: [
                    Icon(p.icon, color: p.color, size: 18),
                    const SizedBox(width: 10),
                    Expanded(child: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark))),
                    Text(p.dist, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;
  final bool showDivider;

  const _ActivityTile({
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 17),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(time, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
                  ],
                ),
              ],
            ),
            if (showDivider) const Padding(padding: EdgeInsets.only(top: 10), child: Divider(height: 1)),
          ],
        ),
      ),
    );
  }
}
