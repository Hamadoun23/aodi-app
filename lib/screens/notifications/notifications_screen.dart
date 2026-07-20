import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotifItem {
  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String subtitle;
  final String time;
  final bool unread;
  final String group;
  const _NotifItem(this.icon, this.color, this.bg, this.title, this.subtitle, this.time, this.unread, this.group);
}

const _items = [
  _NotifItem(Icons.event_available_rounded, AppColors.primary, AppColors.surfaceMuted, 'Rendez-vous confirmé', 'Votre rendez-vous avec Dr Amadou Keïta est confirmé.', '10:30', true, 'Aujourd\'hui'),
  _NotifItem(Icons.chat_bubble_rounded, AppColors.primary, AppColors.surfaceMuted, 'Nouveau message', 'Dr Amadou Keïta vous a envoyé un message.', '09:15', true, 'Aujourd\'hui'),
  _NotifItem(Icons.science_rounded, AppColors.warning, AppColors.warningBg, 'Résultats disponibles', 'Les résultats de votre analyse du 20 Mai sont disponibles.', '08:45', true, 'Aujourd\'hui'),
  _NotifItem(Icons.delivery_dining_rounded, AppColors.success, AppColors.successBg, 'Livreur en approche', 'Votre commande de la Pharmacie ACI 2000 sera livrée dans 15 min.', '18:20', false, 'Hier'),
  _NotifItem(Icons.medication_rounded, AppColors.pink, AppColors.pinkBg, 'Rappel médicament', 'N\'oubliez pas de prendre votre médicament ce soir.', '17:00', false, 'Hier'),
  _NotifItem(Icons.notifications_active_rounded, AppColors.info, AppColors.infoBg, 'Bienvenue sur AODI', 'Merci de faire confiance à AODI pour votre santé.', '12 Mai', false, 'Plus tôt'),
];

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _tab = 0;
  static const _tabs = ['Toutes', 'Non lues', 'Rendez-vous', 'Messages'];

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<_NotifItem>>{};
    for (final it in _items) {
      groups.putIfAbsent(it.group, () => []).add(it);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: Row(
                children: [
                  IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
                  const Expanded(child: Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark))),
                  const Icon(Icons.tune_rounded, color: AppColors.textDark),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final active = i == _tab;
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => setState(() => _tab = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? AppColors.primary : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(_tabs[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.textBody)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: groups.entries.expand((e) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(e.key, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
                    ),
                    ...e.value.map((it) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(color: it.bg, borderRadius: BorderRadius.circular(12)),
                                  child: Icon(it.icon, color: it.color, size: 17),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(it.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                                      const SizedBox(height: 3),
                                      Text(it.subtitle, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted, height: 1.3)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(it.time, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                                    if (it.unread) ...[
                                      const SizedBox(height: 8),
                                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ];
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
