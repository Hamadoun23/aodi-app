import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bogolan_pattern.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  int _tab = 0;
  static const _tabs = ['Historique', 'Ordonnances', 'Analyses', 'Documents', 'Vaccins', 'Allergies'];

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
                IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
                const SizedBox(width: 2),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dossier médical', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                      Text('Votre santé, notre priorité', style: TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.notifications_none_rounded, color: AppColors.textDark),
                const SizedBox(width: 10),
                const CircleAvatar(radius: 16, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                    child: const Row(children: [
                      Icon(Icons.search_rounded, color: AppColors.textMuted, size: 19),
                      SizedBox(width: 8),
                      Expanded(child: Text('Rechercher dans votre dossier...', style: TextStyle(color: AppColors.textMuted, fontSize: 12.5))),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _MedicalCard(),
            const SizedBox(height: 20),
            const Text('Mes informations santé', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            const SizedBox(height: 12),
            const _HealthInfoGrid(),
            const SizedBox(height: 20),
            const _AiInsightsCard(),
            const SizedBox(height: 24),
            _TabRow(tabs: _tabs, index: _tab, onChanged: (i) => setState(() => _tab = i)),
            const SizedBox(height: 16),
            if (_tab == 0) const _HistoryTimeline() else _SimpleTabContent(label: _tabs[_tab]),
            const SizedBox(height: 22),
            const _RecentDocuments(),
            const SizedBox(height: 20),
            const _ShareCard(),
            const SizedBox(height: 20),
            const _NfcCardPromo(),
          ],
        ),
      ),
    );
  }
}

class _MedicalCard extends StatelessWidget {
  const _MedicalCard();

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
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Ma carte médicale', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(10)),
                        child: const Text('Carte intelligente', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/avatar_astou.png')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Astou Diallo', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                            Text('Née le 12 Mai 1998 (28 ans)', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
                            Text('Sexe : Féminin', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(10)),
                              child: const Text('Carte active', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.qr_code_rounded, size: 26, color: AppColors.primary),
                          ),
                          const SizedBox(height: 6),
                          const Icon(Icons.wifi_rounded, color: Colors.white70, size: 18),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        _miniInfo('Groupe sanguin', 'O+'),
                        _miniInfo('Allergies', 'Pénicilline'),
                        _miniInfo('Contact urgence', '+223 76...'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniInfo(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 9.5)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _HealthInfoGrid extends StatelessWidget {
  const _HealthInfoGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Taille', '165 cm', Icons.height_rounded),
      ('Poids', '62 kg', Icons.monitor_weight_rounded),
      ('IMC', '22,8', Icons.speed_rounded),
      ('Tension', '110/70', Icons.favorite_rounded),
      ('Fréq. cardiaque', '72 bpm', Icons.monitor_heart_rounded),
      ('Glycémie', '0,92 g/L', Icons.water_drop_rounded),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.95,
      children: items.map((it) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(it.$3, color: AppColors.primary, size: 17),
              const Spacer(),
              Text(it.$2, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textDark)),
              Text(it.$1, style: const TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _AiInsightsCard extends StatelessWidget {
  const _AiInsightsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.08), AppColors.primaryLight.withValues(alpha: 0.1)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Image.asset('assets/images/robot_mascot.png', width: 30, height: 30),
            const SizedBox(width: 8),
            const Expanded(child: Text('Assistant Santé IA analyse votre dossier', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: AppColors.textDark))),
          ]),
          const SizedBox(height: 12),
          _insightChip(Icons.bloodtype_rounded, 'Votre bilan sanguin date de 12 mois.'),
          _insightChip(Icons.medication_rounded, 'Votre traitement se termine dans 3 jours.'),
          _insightChip(Icons.event_repeat_rounded, 'Rendez-vous de contrôle dans 7 jours.', showDivider: false),
        ],
      ),
    );
  }

  Widget _insightChip(IconData icon, String text, {bool showDivider = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11.5, color: AppColors.textBody))),
        ],
      ),
    );
  }
}

class _TabRow extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final ValueChanged<int> onChanged;
  const _TabRow({required this.tabs, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final active = i == index;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: active ? AppColors.primary : AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(tabs[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.textBody)),
            ),
          );
        },
      ),
    );
  }
}

class _HistoryTimeline extends StatelessWidget {
  const _HistoryTimeline();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('20 Juin 2026', 'Consultation – Cardiologie', 'Dr Amadou Keïta · Clinique AODI Bamako', Icons.event_available_rounded, AppColors.primary, 'Voir le compte rendu'),
      ('10 Mai 2026', 'Analyse sanguine complète', 'Laboratoire Santé+ · Résultats normaux', Icons.science_rounded, AppColors.pink, 'Voir les résultats'),
      ('02 Avril 2026', 'Ordonnance', 'Dr Fatoumata Diallo · Traitement pour 5 jours', Icons.medication_rounded, AppColors.info, 'Voir l\'ordonnance'),
      ('18 Mars 2026', 'Consultation – Médecine générale', 'Dr Issa Traoré · Clinique Pasteur', Icons.medical_services_rounded, AppColors.warning, 'Voir le compte rendu'),
      ('05 Fév 2026', 'Vaccin antitétanique', 'Centre de santé de Lafiabougou', Icons.vaccines_rounded, AppColors.success, 'Voir détails'),
    ];
    return Column(
      children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        final it = e.value;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: it.$5, shape: BoxShape.circle)),
                  if (!isLast) Expanded(child: Container(width: 2, color: AppColors.border)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(it.$1, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Row(children: [
                          Icon(it.$4, size: 15, color: it.$5),
                          const SizedBox(width: 6),
                          Expanded(child: Text(it.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark))),
                        ]),
                        const SizedBox(height: 3),
                        Text(it.$3, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), textStyle: const TextStyle(fontSize: 10.5)),
                            child: Text(it.$6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SimpleTabContent extends StatelessWidget {
  final String label;
  const _SimpleTabContent({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.folder_open_rounded, color: AppColors.textMuted, size: 32),
          const SizedBox(height: 10),
          Text('Aucun élément dans "$label" pour le moment.', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _RecentDocuments extends StatelessWidget {
  const _RecentDocuments();

  @override
  Widget build(BuildContext context) {
    final docs = [
      ('Résultats ECG.pdf', '20 Juin 2026 · 1.2 Mo'),
      ('Ordonnance_Cardiologie.pdf', '20 Juin 2026 · 0.8 Mo'),
      ('Bilan sanguin_12Mai2026.pdf', '10 Mai 2026 · 1.4 Mo'),
      ('Radio_thorax.jpg', '02 Avril 2026 · 2.1 Mo'),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Expanded(child: Text('Documents récents', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textDark))),
            Text('Voir tout', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
          ]),
          const SizedBox(height: 10),
          ...docs.map((d) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.dangerBg, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.danger, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.$1, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textDark)),
                          Text(d.$2, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    const Icon(Icons.file_download_outlined, color: AppColors.primary, size: 18),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _ShareCard extends StatelessWidget {
  const _ShareCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.people_alt_rounded, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text('Partagez vos documents avec un médecin ou un établissement en toute sécurité.', style: TextStyle(fontSize: 11.5, color: AppColors.textBody)),
          ),
        ],
      ),
    );
  }
}

class _NfcCardPromo extends StatelessWidget {
  const _NfcCardPromo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            const Icon(Icons.nfc_rounded, color: Colors.white, size: 30),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Carte médicale intelligente (NFC)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                  SizedBox(height: 4),
                  Text('Présentez-la en clinique pour un accès rapide et sécurisé.', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
