import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String sub;
  final String avatar;
  const ChatScreen({super.key, required this.name, required this.sub, required this.avatar});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final List<(bool fromMe, String text)> _messages = [
    (false, 'Bonjour Astou, comment vous sentez-vous aujourd\'hui ?'),
    (true, 'Bonjour Docteur, un peu mieux mais j\'ai toujours des essoufflements.'),
    (false, 'D\'accord, continuez le traitement prescrit et nous ferons un point vendredi.'),
  ];

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add((true, text));
      _ctrl.clear();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
              child: Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
                  CircleAvatar(radius: 18, backgroundImage: AssetImage(widget.avatar)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
                        Text(widget.sub, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  const Icon(Icons.call_rounded, color: AppColors.primary, size: 20),
                  const SizedBox(width: 14),
                  const Icon(Icons.videocam_rounded, color: AppColors.primary, size: 20),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: _messages.map((m) {
                  return Align(
                    alignment: m.$1 ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                      decoration: BoxDecoration(
                        color: m.$1 ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: m.$1 ? null : Border.all(color: AppColors.border),
                      ),
                      child: Text(m.$2, style: TextStyle(color: m.$1 ? Colors.white : AppColors.textDark, fontSize: 13, height: 1.35)),
                    ),
                  );
                }).toList(),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        decoration: const InputDecoration(hintText: 'Écrire un message...', isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 16)),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: _send,
                      borderRadius: BorderRadius.circular(24),
                      child: const CircleAvatar(radius: 22, backgroundColor: AppColors.primary, child: Icon(Icons.send_rounded, color: Colors.white, size: 18)),
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
}
