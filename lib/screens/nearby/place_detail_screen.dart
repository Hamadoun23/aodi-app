import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/map_placeholder.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String name;
  final String category;
  const PlaceDetailScreen({super.key, required this.name, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
Container(
                  height: 190,
                  decoration: const BoxDecoration(gradient: AppColors.heroGradient),
                  child: const MapPlaceholder(
                    height: 190,
                    borderRadius: BorderRadius.zero,
                    pins: [MapPin(Alignment.center, AppColors.success, Icons.local_pharmacy_rounded)],
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: _roundIconBtn(Icons.arrow_back_rounded, () => Navigator.of(context).pop()),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(children: [
                    _roundIconBtn(Icons.ios_share_rounded, () {}),
                    const SizedBox(width: 8),
                    _roundIconBtn(Icons.favorite_border_rounded, () {}),
                  ]),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -22),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: const BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.textDark))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(20)),
                          child: const Text('Ouvert', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w700, fontSize: 11.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const Text(' 4,7 (254 avis)  ·  ', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                      Text(category, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ]),
                    const SizedBox(height: 2),
                    const Text('1,2 km de votre position', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        _actionBtn(Icons.call_rounded, 'Appeler'),
                        _actionBtn(Icons.directions_rounded, 'Itinéraire', active: true),
                        _actionBtn(Icons.bookmark_border_rounded, 'Enregistrer'),
                        _actionBtn(Icons.ios_share_rounded, 'Partager'),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Text('Informations', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textDark)),
                    const SizedBox(height: 10),
                    _infoRow(Icons.location_on_rounded, 'Hamdallaye ACI 2000, Bamako, Mali'),
                    _infoRow(Icons.access_time_rounded, 'Ouvert maintenant · 07:00 – 22:00'),
                    const SizedBox(height: 20),
                    const Text('Services disponibles', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textDark)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['Médicaments', 'Parapharmacie', 'Livraison à domicile'].map((s) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: BorderRadius.circular(20)),
                          child: Text(s, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.upload_file_rounded, size: 18),
                        label: const Text('Envoyer mon ordonnance'),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundIconBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 6)]),
        child: Icon(icon, size: 18, color: AppColors.textDark),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, {bool active = false}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: active ? Colors.white : AppColors.primary, size: 19),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5, color: AppColors.textBody))),
        ],
      ),
    );
  }
}

