import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../data/mock_data.dart';

/// Parcours de prise de rendez-vous en 6 étapes, fidèle à la maquette
/// desktop "Prendre un rendez-vous", adapté à un déroulé mobile.
class BookingFlowScreen extends StatefulWidget {
  const BookingFlowScreen({super.key});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _step = 0;
  static const _stepTitles = ['Besoin', 'Spécialité', 'Médecin', 'Type', 'Date & heure', 'Confirmation'];

  String? _reason;
  String? _speciality;
  Doctor? _doctor;
  String? _consultationType;
  int? _dayIndex;
  String? _time;

  bool get _canContinue {
    switch (_step) {
      case 0:
        return _reason != null;
      case 1:
        return _speciality != null;
      case 2:
        return _doctor != null;
      case 3:
        return _consultationType != null;
      case 4:
        return _dayIndex != null && _time != null;
      default:
        return true;
    }
  }

  void _next() {
    if (_step < 5) {
      setState(() => _step++);
    } else {
      _showConfirmedSheet();
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step--);
    }
  }

  void _showConfirmedSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(color: AppColors.successBg, shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: AppColors.success, size: 40),
            ),
            const SizedBox(height: 18),
            const Text('Rendez-vous confirmé !', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            const SizedBox(height: 8),
            Text(
              'Votre rendez-vous avec ${_doctor?.name} a bien été enregistré.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textBody, fontSize: 13),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Retour à mes rendez-vous'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStepper(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                layoutBuilder: (currentChild, previousChildren) => currentChild ?? const SizedBox.shrink(),
                child: SingleChildScrollView(
                  key: ValueKey(_step),
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: _buildStepBody(),
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 20, 6),
      child: Row(
        children: [
          IconButton(onPressed: _back, icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textDark)),
          const Expanded(
            child: Text('Prendre un rendez-vous', style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: List.generate(_stepTitles.length, (i) {
          final done = i < _step;
          final active = i == _step;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 5,
                    margin: EdgeInsets.only(right: i == _stepTitles.length - 1 ? 0 : 4),
                    decoration: BoxDecoration(
                      color: done || active ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepBody() {
    switch (_step) {
      case 0:
        return _StepBesoin(value: _reason, onSelect: (v) => setState(() => _reason = v));
      case 1:
        return _StepSpeciality(value: _speciality, onSelect: (v) => setState(() => _speciality = v));
      case 2:
        return _StepDoctor(value: _doctor, onSelect: (v) => setState(() => _doctor = v));
      case 3:
        return _StepType(value: _consultationType, onSelect: (v) => setState(() => _consultationType = v));
      case 4:
        return _StepDateTime(
          dayIndex: _dayIndex,
          time: _time,
          onDaySelect: (v) => setState(() => _dayIndex = v),
          onTimeSelect: (v) => setState(() => _time = v),
        );
      default:
        return _StepConfirmation(
          doctor: _doctor ?? doctorAmadou,
          consultationType: _consultationType ?? 'Vidéo',
          time: _time ?? '10h30',
        );
    }
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _canContinue ? _next : null,
          child: Text(_step == 5 ? 'Confirmer le rendez-vous' : 'Continuer'),
        ),
      ),
    );
  }
}

// ---------- Étape 1 : Besoin ----------
class _StepBesoin extends StatelessWidget {
  final String? value;
  final ValueChanged<String> onSelect;
  const _StepBesoin({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = [
      (icon: Icons.sick_rounded, label: 'Je suis malade'),
      (icon: Icons.favorite_rounded, label: 'Consultation de suivi'),
      (icon: Icons.child_care_rounded, label: 'Pédiatrie'),
      (icon: Icons.pregnant_woman_rounded, label: 'Gynécologie'),
      (icon: Icons.receipt_long_rounded, label: 'Renouveler une ordonnance'),
      (icon: Icons.science_rounded, label: 'Faire une analyse'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('De quoi avez-vous besoin aujourd\'hui ?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Décrivez votre situation ou choisissez une option ci-dessous.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/robot_mascot.png', width: 34, height: 34),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assistant IA AODI', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: AppColors.textDark)),
                    SizedBox(height: 3),
                    Text('Décrivez rapidement votre problème et je vous orienterai au mieux.', style: TextStyle(fontSize: 11, color: AppColors.textBody)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text('Ou sélectionnez une raison', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.6,
          children: options.map((o) {
            final selected = value == o.label;
            return _SelectableTile(icon: o.icon, label: o.label, selected: selected, onTap: () => onSelect(o.label));
          }).toList(),
        ),
      ],
    );
  }
}

class _SelectableTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SelectableTile({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.6 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: selected ? AppColors.primary : AppColors.textBody),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: selected ? AppColors.primary : AppColors.textDark)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Étape 2 : Spécialité ----------
class _StepSpeciality extends StatelessWidget {
  final String? value;
  final ValueChanged<String> onSelect;
  const _StepSpeciality({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final specialities = [
      (icon: Icons.favorite_rounded, label: 'Cardiologie', count: 12),
      (icon: Icons.medical_services_rounded, label: 'Médecine générale', count: 18),
      (icon: Icons.child_friendly_rounded, label: 'Pédiatrie', count: 9),
      (icon: Icons.pregnant_woman_rounded, label: 'Gynécologie', count: 11),
      (icon: Icons.psychology_rounded, label: 'Neurologie', count: 7),
      (icon: Icons.healing_rounded, label: 'Orthopédie', count: 8),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choisissez une spécialité', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Sélectionnez la spécialité qui correspond le mieux à votre besoin.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        ...specialities.map((s) {
          final selected = value == s.label;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onSelect(s.label),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary.withValues(alpha: 0.06) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.6 : 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.pinkBg, borderRadius: BorderRadius.circular(12)),
                      child: Icon(s.icon, color: AppColors.pink, size: 19),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textDark)),
                          Text('${s.count} médecins disponibles', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    Icon(selected ? Icons.check_circle_rounded : Icons.chevron_right_rounded, color: selected ? AppColors.primary : AppColors.textMuted),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ---------- Étape 3 : Médecin ----------
class _StepDoctor extends StatelessWidget {
  final Doctor? value;
  final ValueChanged<Doctor> onSelect;
  const _StepDoctor({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choisissez un médecin', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Selon votre localisation, voici les meilleurs choix.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        ...allDoctors.map((d) {
          final selected = value?.name == d.name;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onSelect(d),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary.withValues(alpha: 0.06) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.6 : 1),
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: 26, backgroundImage: AssetImage(d.avatar)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textDark)),
                          Text(d.speciality, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                              Text(' ${d.rating} (${d.reviews})  ', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                              const Icon(Icons.location_on_rounded, color: AppColors.textMuted, size: 12),
                              Text(' ${d.distanceKm} km', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(selected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded, color: selected ? AppColors.primary : AppColors.border),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ---------- Étape 4 : Type de consultation ----------
class _StepType extends StatelessWidget {
  final String? value;
  final ValueChanged<String> onSelect;
  const _StepType({required this.value, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final types = [
      (icon: Icons.videocam_rounded, label: 'Vidéo', desc: 'Consultez le médecin face à face en vidéo.'),
      (icon: Icons.call_rounded, label: 'Appel vocal', desc: 'Parlez au médecin en appel vocal.'),
      (icon: Icons.chat_bubble_rounded, label: 'Chat', desc: 'Discutez avec le médecin par messagerie.'),
      (icon: Icons.apartment_rounded, label: 'En clinique', desc: 'Rendez-vous au cabinet ou à la clinique.'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choisissez le type de consultation', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Sélectionnez le mode qui vous convient le mieux.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        ...types.map((t) {
          final selected = value == t.label;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onSelect(t.label),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary.withValues(alpha: 0.06) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.6 : 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.infoBg, borderRadius: BorderRadius.circular(12)),
                      child: Icon(t.icon, color: AppColors.info, size: 19),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textDark)),
                          Text(t.desc, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    Icon(selected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded, color: selected ? AppColors.primary : AppColors.border),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.infoBg, borderRadius: BorderRadius.circular(14)),
          child: const Row(
            children: [
              Icon(Icons.verified_user_rounded, color: AppColors.info, size: 18),
              SizedBox(width: 8),
              Expanded(child: Text('Toutes nos consultations en ligne sont sécurisées et confidentielles.', style: TextStyle(fontSize: 11, color: AppColors.info))),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- Étape 5 : Date & heure ----------
class _StepDateTime extends StatelessWidget {
  final int? dayIndex;
  final String? time;
  final ValueChanged<int> onDaySelect;
  final ValueChanged<String> onTimeSelect;
  const _StepDateTime({required this.dayIndex, required this.time, required this.onDaySelect, required this.onTimeSelect});

  @override
  Widget build(BuildContext context) {
    const days = [23, 24, 25, 26, 27, 28, 29, 30];
    const weekdays = ['LUN', 'MAR', 'MER', 'JEU', 'VEN', 'SAM', 'DIM'];
    const slots = ['08h00', '08h30', '09h00', '09h30', '10h30', '11h00', '14h00', '14h30', '15h00', '15h30', '16h00'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choisissez la date et l\'heure', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Sélectionnez un créneau disponible qui vous convient.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.chevron_left_rounded, color: AppColors.textMuted),
            Text('Juin 2026', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.textDark)),
            Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 74,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final selected = dayIndex == i;
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => onDaySelect(i),
                child: Container(
                  width: 52,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(weekdays[i % 7], style: TextStyle(fontSize: 9.5, color: selected ? Colors.white70 : AppColors.textMuted, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text('${days[i]}', style: TextStyle(fontSize: 15, color: selected ? Colors.white : AppColors.textDark, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Text('Créneaux disponibles', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: slots.map((s) {
            final selected = time == s;
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onTimeSelect(s),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                ),
                child: Text(s, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: selected ? Colors.white : AppColors.textDark)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(12)),
          child: const Row(
            children: [
              Icon(Icons.schedule_rounded, size: 16, color: AppColors.textMuted),
              SizedBox(width: 8),
              Text('Heure locale : UTC+0 · Bamako, Mali', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- Étape 6 : Confirmation ----------
class _StepConfirmation extends StatelessWidget {
  final Doctor doctor;
  final String consultationType;
  final String time;
  const _StepConfirmation({required this.doctor, required this.consultationType, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Résumé de votre rendez-vous', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 6),
        const Text('Vérifiez les informations avant de confirmer.', style: TextStyle(fontSize: 12.5, color: AppColors.textBody)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 26, backgroundImage: AssetImage(doctor.avatar)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textDark)),
                        Text(doctor.speciality, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        Row(children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                          Text(' ${doctor.rating} (${doctor.reviews} avis)', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1)),
              _summaryRow(Icons.videocam_rounded, 'Type de consultation', consultationType),
              _summaryRow(Icons.calendar_today_rounded, 'Date', 'Jeudi 25 Juin 2026'),
              _summaryRow(Icons.access_time_rounded, 'Heure', time),
              _summaryRow(Icons.timelapse_rounded, 'Durée', '30 minutes'),
              _summaryRow(Icons.payments_rounded, 'Montant', '15 000 FCFA'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Documents à préparer', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: AppColors.textDark)),
              const SizedBox(height: 8),
              _checkRow('Pièce d\'identité'),
              _checkRow('Dossier médical (si disponible)'),
              _checkRow('Résultats d\'analyses (si disponibles)'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'En confirmant, vous acceptez nos conditions d\'utilisation et notre politique de confidentialité.',
          style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted))),
          Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _checkRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, size: 15, color: AppColors.success),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
