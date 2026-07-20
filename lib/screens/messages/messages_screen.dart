import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      (avatar: 'assets/images/avatar_amadou.png', name: 'Dr Amadou Keïta', sub: 'Cardiologue', last: 'D\'accord, depuis combien de temps ressentez-vous cela ?', time: '10:23', unread: 2, online: true),
      (avatar: 'assets/images/robot_mascot.png', name: 'Assistant IA AODI', sub: 'Assistant santé', last: 'Souhaitez-vous programmer une visite de contrôle ?', time: '09:40', unread: 1, online: true),
      (avatar: 'assets/images/avatar_fatoumata_sissoko.png', name: 'Dr Fatoumata Sissoko', sub: 'Dermatologue', last: 'Votre ordonnance a été envoyée à la pharmacie.', time: 'Hier', unread: 0, online: false),
      (avatar: 'assets/images/avatar_moussa_traore.png', name: 'Dr Moussa Traoré', sub: 'Médecin généraliste', last: 'Merci de confirmer votre rendez-vous de vendredi.', time: 'Hier', unread: 0, online: false),
      (avatar: 'assets/images/avatar_oumar_traore.png', name: 'Dr Oumar Traoré', sub: 'Cardiologue', last: 'Vos résultats sont normaux, continuez le traitement.', time: '18 Juin', unread: 0, online: false),
    ];

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
                  const Expanded(child: Text('Messages', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark))),
                  const CircleAvatar(radius: 17, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                child: const Row(children: [
                  Icon(Icons.search_rounded, color: AppColors.textMuted, size: 19),
                  SizedBox(width: 8),
                  Expanded(child: Text('Rechercher une conversation...', style: TextStyle(color: AppColors.textMuted, fontSize: 12.5))),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 110),
                itemCount: conversations.length,
                separatorBuilder: (_, __) => const Divider(height: 22),
                itemBuilder: (context, i) {
                  final c = conversations[i];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatScreen(name: c.name, sub: c.sub, avatar: c.avatar))),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 26, backgroundImage: AssetImage(c.avatar)),
                            if (c.online)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(color: AppColors.success, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textDark))),
                                  Text(c.time, style: TextStyle(fontSize: 10.5, color: c.unread > 0 ? AppColors.primary : AppColors.textMuted, fontWeight: c.unread > 0 ? FontWeight.w700 : FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(c.last, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                                  ),
                                  if (c.unread > 0) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                                      child: Text('${c.unread}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700)),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
