import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StepDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const StepDetailScreen({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
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
                const Expanded(child: Text('Détail de l\'étape', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark))),
                const Icon(Icons.more_vert_rounded, color: AppColors.textDark),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.science_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$title médicale', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Row(
                children: [
                  const Icon(Icons.biotech_rounded, color: AppColors.primary, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Laboratoire', style: TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                        Text('Laboratoire Santé+', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Ouvert', style: TextStyle(color: AppColors.success, fontSize: 10.5, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.call_rounded, color: AppColors.primary, size: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Informations', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textDark)),
            const SizedBox(height: 10),
            _infoLine('Ordonnance', 'ORD-2025-0520-00125'),
            _infoLine('Date d\'envoi', '20 Mai 2025 à 14:30'),
            _infoLine('Date estimée des résultats', '21 Mai 2025'),
            _infoLine('Type d\'analyses', 'Voir détails', chevron: true),
            const SizedBox(height: 22),
            const Text('Statut actuel', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textDark)),
            const SizedBox(height: 16),
            const _StatusStepper(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.infoBg, borderRadius: BorderRadius.circular(14)),
              child: const Row(
                children: [
                  Icon(Icons.notifications_active_rounded, color: AppColors.info, size: 18),
                  SizedBox(width: 10),
                  Expanded(child: Text('Nous vous notifierons dès que vos résultats seront disponibles.', style: TextStyle(fontSize: 11.5, color: AppColors.info))),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Voir mes résultats'))),
            const SizedBox(height: 10),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, child: const Text('Contacter le laboratoire'))),
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String value, {bool chevron = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted))),
          Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          if (chevron) const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}

class _StatusStepper extends StatelessWidget {
  const _StatusStepper();

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Reçu', '20 Mai 14:30', true, false),
      ('En cours', '20 Mai 15:10', true, true),
      ('Qualité', 'À venir', false, false),
      ('Résultats', 'À venir', false, false),
    ];
    return Row(
      children: steps.map((s) {
        final (label, time, done, active) = s;
        final isLast = s == steps.last;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(color: done || active ? AppColors.primary : AppColors.border, shape: BoxShape.circle),
                    ),
                  ),
                  if (!isLast) Expanded(child: Container(height: 2, color: done ? AppColors.primary : AppColors.border)),
                ],
              ),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: active ? AppColors.primary : AppColors.textDark)),
              Text(time, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
