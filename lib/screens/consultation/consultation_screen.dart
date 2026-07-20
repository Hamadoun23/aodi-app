import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool micOn = true;
  bool camOn = true;
  final _messageCtrl = TextEditingController();
  final List<(bool fromMe, String text)> _messages = [
    (true, 'Bonjour Docteur, j\'ai souvent cette douleur quand je monte les escaliers.'),
    (false, 'D\'accord, depuis combien de temps ressentez-vous cela exactement ?'),
  ];

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _messageCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add((true, text));
      _messageCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildVideoArea(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
                  children: [
                    _assistantCard(),
                    const SizedBox(height: 18),
                    _quickTools(),
                    const SizedBox(height: 18),
                    _chatCard(),
                    const SizedBox(height: 18),
                    _paymentCard(),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                        icon: const Icon(Icons.call_end_rounded),
                        label: const Text('Terminer la consultation'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
          const CircleAvatar(radius: 18, backgroundImage: AssetImage('assets/images/avatar_amadou.png')),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr Amadou Keïta', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13.5)),
                Text('Cardiologue · En ligne', style: TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: AppColors.danger, size: 8),
                SizedBox(width: 6),
                Text('00:08:42', style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoArea() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF2A2140), Color(0xFF120B24)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 56, backgroundImage: AssetImage('assets/images/avatar_amadou.png')),
                const SizedBox(height: 10),
                Text('Dr Amadou Keïta', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_rounded, color: AppColors.success, size: 13),
                  SizedBox(width: 4),
                  Text('Connexion excellente', style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              width: 74,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24),
                image: const DecorationImage(image: AssetImage('assets/images/avatar_astou.png'), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _callBtn(micOn ? Icons.mic_rounded : Icons.mic_off_rounded, active: micOn, onTap: () => setState(() => micOn = !micOn)),
                  _callBtn(camOn ? Icons.videocam_rounded : Icons.videocam_off_rounded, active: camOn, onTap: () => setState(() => camOn = !camOn)),
                  _callBtn(Icons.chat_bubble_rounded, onTap: () {}),
                  _callBtn(Icons.description_rounded, onTap: () {}),
                  _callBtn(Icons.call_end_rounded, danger: true, onTap: () => Navigator.of(context).pop()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _callBtn(IconData icon, {bool active = true, bool danger = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: danger ? AppColors.danger : (active ? Colors.white24 : Colors.white10),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: child,
    );
  }

  Widget _assistantCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.08), AppColors.primaryLight.withValues(alpha: 0.1)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/images/robot_mascot.png', width: 30, height: 30),
              const SizedBox(width: 8),
              const Text('Assistant IA AODI', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.textDark)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                child: const Text('BETA', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _assistantRow('Résumé automatique', 'Douleur thoracique et essoufflement depuis 2 jours.', Icons.summarize_rounded),
          _assistantRow('Symptômes détectés', 'Douleur thoracique, essoufflement, fatigue légère.', Icons.monitor_heart_rounded),
          _assistantRow('Éléments clés', 'Antécédent d\'hypertension, stress, douleur à l\'effort.', Icons.fact_check_rounded, showDivider: false),
        ],
      ),
    );
  }

  Widget _assistantRow(String title, String desc, IconData icon, {bool showDivider = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: AppColors.textDark)),
                    const SizedBox(height: 2),
                    Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.textBody, height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
          if (showDivider) const Padding(padding: EdgeInsets.only(top: 10), child: Divider(height: 1)),
        ],
      ),
    );
  }

  Widget _quickTools() {
    final tools = [
      (Icons.description_rounded, 'Ordonnance'),
      (Icons.science_rounded, 'Analyses'),
      (Icons.folder_rounded, 'Dossier'),
      (Icons.ios_share_rounded, 'Partager'),
    ];
    return Row(
      children: tools.map((t) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(14)),
                  child: Icon(t.$1, color: AppColors.primary, size: 20),
                ),
                const SizedBox(height: 6),
                Text(t.$2, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.textDark), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _chatCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lock_rounded, size: 14, color: AppColors.textMuted),
              SizedBox(width: 6),
              Text('Chat sécurisé', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.textDark)),
            ],
          ),
          const SizedBox(height: 12),
          ..._messages.map((m) => Align(
                alignment: m.$1 ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  constraints: const BoxConstraints(maxWidth: 240),
                  decoration: BoxDecoration(
                    color: m.$1 ? AppColors.primary : AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(m.$2, style: TextStyle(color: m.$1 ? Colors.white : AppColors.textDark, fontSize: 12.5)),
                ),
              )),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Écrire un message...',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _send,
                borderRadius: BorderRadius.circular(20),
                child: const CircleAvatar(radius: 19, backgroundColor: AppColors.primary, child: Icon(Icons.send_rounded, color: Colors.white, size: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return _card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.payments_rounded, color: AppColors.success, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Paiement', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                Text('Orange Money · 15 000 FCFA', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          const Text('Payé', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w800, fontSize: 12.5)),
        ],
      ),
    );
  }
}
