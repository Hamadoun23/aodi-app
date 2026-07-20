import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bogolan_pattern.dart';
import '../../widgets/status_pill.dart';
import '../booking/booking_flow_screen.dart';
import '../consultation/consultation_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  final ValueChanged<int> onNavigate;
  const AppointmentsScreen({super.key, required this.onNavigate});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 110),
          children: [
            Row(
              children: [
                const Text('Rendez-vous', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                const Spacer(),
                const Icon(Icons.notifications_none_rounded, color: AppColors.textDark),
                const SizedBox(width: 12),
                const CircleAvatar(radius: 17, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
              ],
            ),
            const SizedBox(height: 14),
            const Text('Bonjour Astou 👋', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            const SizedBox(height: 2),
            const Text('Vous avez 2 rendez-vous à venir.', style: TextStyle(fontSize: 13, color: AppColors.textBody)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                    child: const Row(children: [
                      Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Rechercher un rendez-vous...', style: TextStyle(color: AppColors.textMuted, fontSize: 13))),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(14)),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.filter_list_rounded, color: Colors.white, size: 17),
                    SizedBox(width: 5),
                    Text('Filtres', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingFlowScreen())),
                icon: const Icon(Icons.add_rounded, size: 19),
                label: const Text('Prendre rendez-vous'),
              ),
            ),
            const SizedBox(height: 26),
            const Text('Mon parcours de soin', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            const SizedBox(height: 14),
            const _CareJourney(),
            const SizedBox(height: 26),
            _SegmentedTabs(index: _tab, onChanged: (i) => setState(() => _tab = i)),
            const SizedBox(height: 16),
            if (_tab == 0) ..._buildUpcoming(context) else if (_tab == 1) ..._buildPast() else ..._buildCancelled(),
            const SizedBox(height: 22),
            _AdviceBanner(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildUpcoming(BuildContext context) {
    return [
      _NextAppointmentCard(
        onDetails: () {},
        onJoin: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConsultationScreen())),
      ),
      const SizedBox(height: 18),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _PreparationCard()),
          const SizedBox(width: 12),
          Expanded(child: _AiSuggestionCard()),
        ],
      ),
      const SizedBox(height: 22),
      const Text('Vos prochains rendez-vous', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark)),
      const SizedBox(height: 12),
      _UpcomingRow(
        day: 'LUN', date: '30', month: 'JUIN',
        avatar: 'assets/images/avatar_fatoumata_sissoko.png',
        name: 'Dr Fatoumata Sissoko', speciality: 'Dermatologue',
        time: '11h00', mode: 'En ligne', modeIcon: Icons.videocam_rounded,
      ),
      const SizedBox(height: 10),
      _UpcomingRow(
        day: 'VEN', date: '04', month: 'JUIL',
        avatar: 'assets/images/avatar_moussa_traore.png',
        name: 'Dr Moussa Traoré', speciality: 'Médecin généraliste',
        time: '09h30', mode: 'En présentiel', modeIcon: Icons.person_rounded,
      ),
      const SizedBox(height: 12),
      Center(
        child: TextButton(
          onPressed: () {},
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Voir tous les rendez-vous'),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.primary),
          ]),
        ),
      ),
    ];
  }

  List<Widget> _buildPast() {
    return const [
      _PastRow(name: 'Dr Amadou Keïta', speciality: 'Cardiologue', date: '20 Juin 2026', avatar: 'assets/images/avatar_amadou.png'),
      SizedBox(height: 10),
      _PastRow(name: 'Dr Fatoumata Diallo', speciality: 'Cardiologue', date: '02 Avril 2026', avatar: 'assets/images/avatar_fatoumata_diallo.png'),
      SizedBox(height: 10),
      _PastRow(name: 'Dr Oumar Traoré', speciality: 'Cardiologue', date: '18 Mars 2026', avatar: 'assets/images/avatar_oumar_traore.png'),
    ];
  }

  List<Widget> _buildCancelled() {
    return const [
      _PastRow(name: 'Dr Moussa Traoré', speciality: 'Médecin généraliste', date: '05 Février 2026', avatar: 'assets/images/avatar_moussa_traore.png', cancelled: true),
    ];
  }
}

class _CareJourney extends StatelessWidget {
  const _CareJourney();

  @override
  Widget build(BuildContext context) {
    final steps = [
      (icon: Icons.event_available_rounded, label: '1. Rendez-vous', sub: 'Confirmé', done: true),
      (icon: Icons.videocam_rounded, label: '2. Consultation', sub: 'À venir', done: true),
      (icon: Icons.description_rounded, label: '3. Ordonnance', sub: 'En attente', done: false),
      (icon: Icons.local_shipping_rounded, label: '4. Livraison', sub: 'À suivre', done: false),
    ];
    return Row(
      children: steps.map((s) {
        final isLast = s == steps.last;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: s.done ? AppColors.success : AppColors.surfaceMuted,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(s.icon, color: s.done ? Colors.white : AppColors.textMuted, size: 18),
                    ),
                  ),
                  if (!isLast)
                    Container(width: 18, height: 2, color: s.done ? AppColors.success.withValues(alpha: 0.4) : AppColors.border),
                ],
              ),
              const SizedBox(height: 6),
              Text(s.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
              Text(s.sub, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _SegmentedTabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final labels = ['À venir (2)', 'Passés (5)', 'Annulés (1)'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: List.generate(labels.length, (i) {
          final active = i == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[i],
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.textBody),
                ),
              ),
            ),
          );
        }),
      ),
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
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(22)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            const Positioned.fill(child: BogolanPattern()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
                        child: const Text('PROCHAIN RENDEZ-VOUS', style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800)),
                      ),
                      const Spacer(),
                      StatusPill.confirmed(),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/images/avatar_amadou.png')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Dr Amadou Keïta', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                            const Text('Cardiologue', style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                            Text('Clinique AODI Bamako', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 13),
                      const SizedBox(width: 6),
                      const Text('Mercredi 25 Juin', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 14),
                      const Icon(Icons.access_time_rounded, color: Colors.white, size: 13),
                      const SizedBox(width: 6),
                      const Text('10h30 · 30 min', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onDetails,
                          style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(vertical: 12)),
                          child: const Text('Voir les détails', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onJoin,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)),
                          icon: const Icon(Icons.videocam_rounded, size: 15),
                          label: const Text('Rejoindre', style: TextStyle(fontSize: 12)),
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

class _PreparationCard extends StatelessWidget {
  const _PreparationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Votre préparation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(value: 1, strokeWidth: 6, color: AppColors.success, backgroundColor: AppColors.successBg),
                  ),
                  const Text('100%', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.success)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Vous êtes prêt(e) pour votre consultation', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _AiSuggestionCard extends StatelessWidget {
  const _AiSuggestionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Image.asset('assets/images/robot_mascot.png', width: 24, height: 24),
            const SizedBox(width: 6),
            const Expanded(child: Text('Assistant IA', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.textDark))),
          ]),
          const SizedBox(height: 8),
          const Text('Souhaitez-vous programmer une visite de contrôle ?', style: TextStyle(fontSize: 10.5, color: AppColors.textBody, height: 1.3)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 9), textStyle: const TextStyle(fontSize: 10.5)),
              child: const Text('Oui, programmer'),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingRow extends StatelessWidget {
  final String day, date, month, avatar, name, speciality, time, mode;
  final IconData modeIcon;
  const _UpcomingRow({
    required this.day, required this.date, required this.month, required this.avatar,
    required this.name, required this.speciality, required this.time, required this.mode, required this.modeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Column(children: [
            Text(day, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
            Text(date, style: const TextStyle(fontSize: 17, color: AppColors.primary, fontWeight: FontWeight.w800)),
            Text(month, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(width: 12),
          CircleAvatar(radius: 22, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                Text(speciality, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark)),
              Row(children: [
                Icon(modeIcon, size: 11, color: AppColors.primary),
                const SizedBox(width: 3),
                Text(mode, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ]),
              const SizedBox(height: 3),
              StatusPill.confirmed(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PastRow extends StatelessWidget {
  final String name, speciality, date, avatar;
  final bool cancelled;
  const _PastRow({required this.name, required this.speciality, required this.date, required this.avatar, this.cancelled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                Text('$speciality · $date', style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
              ],
            ),
          ),
          cancelled ? StatusPill.cancelled() : StatusPill(label: 'Terminé', color: AppColors.info, background: AppColors.infoBg, icon: Icons.check_circle_rounded),
        ],
      ),
    );
  }
}

class _AdviceBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            const Icon(Icons.shield_moon_rounded, color: Colors.white, size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Conseil du jour', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13.5)),
                  SizedBox(height: 3),
                  Text('Un suivi régulier permet de prévenir et de mieux traiter les maladies.', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
