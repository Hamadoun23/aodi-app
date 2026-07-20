import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bogolan_pattern.dart';
import 'step_detail_screen.dart';

class HealthJourneyScreen extends StatelessWidget {
  const HealthJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Consultation', 'Terminée le 20 Mai 2025 à 10:00', Icons.event_available_rounded, true, false),
      ('Ordonnance', 'Ordonnance émise et envoyée', Icons.description_rounded, true, false),
      ('Pharmacie', 'Commande préparée', Icons.local_pharmacy_rounded, true, false),
      ('Livraison', 'Livrée le 20 Mai 2025 à 14:30', Icons.local_shipping_rounded, true, false),
      ('Traitement', 'En cours', Icons.medication_rounded, true, false),
      ('Analyse', 'En attente des résultats', Icons.science_rounded, false, true),
      ('Résultats', 'À venir', Icons.fact_check_rounded, false, false),
      ('Suivi', 'À venir', Icons.favorite_rounded, false, false),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          children: [
            Row(
              children: [
                IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
                const SizedBox(width: 2),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mon parcours de santé', style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                      Text('Suivez chaque étape de votre prise en charge', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    const Positioned.fill(child: BogolanPattern()),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ÉTAT ACTUEL', style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                                const SizedBox(height: 6),
                                const Text('En attente des résultats', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 6),
                                Text('Votre analyse est en cours au laboratoire. Vous serez notifié(e) dès que les résultats seront disponibles.',
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11.5, height: 1.4)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                            child: const Icon(Icons.biotech_rounded, color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            ...steps.asMap().entries.map((e) {
              final isLast = e.key == steps.length - 1;
              final (title, sub, icon, done, active) = e.value;
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StepDetailScreen(title: title, subtitle: sub))),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: done ? AppColors.success : (active ? AppColors.warning : AppColors.surfaceMuted),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              done ? Icons.check_rounded : icon,
                              color: done || active ? Colors.white : AppColors.textMuted,
                              size: 17,
                            ),
                          ),
                          if (!isLast) Expanded(child: Container(width: 2, color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 22, top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: active ? AppColors.warning : AppColors.textDark)),
                              const SizedBox(height: 2),
                              Text(sub, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
                    ],
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Image.asset('assets/images/robot_mascot.png', width: 32, height: 32),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Besoin d\'aide ? Parlez à l\'assistant IA pour toute question sur votre parcours.', style: TextStyle(fontSize: 11.5, color: AppColors.textBody)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), textStyle: const TextStyle(fontSize: 11.5)),
                    child: const Text('Discuter'),
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
