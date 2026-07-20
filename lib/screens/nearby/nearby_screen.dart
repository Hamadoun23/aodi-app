import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/map_placeholder.dart';
import 'place_detail_screen.dart';

class NearbyScreen extends StatefulWidget {
  final ValueChanged<int> onNavigate;
  const NearbyScreen({super.key, required this.onNavigate});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _Place {
  final String name;
  final String category;
  final IconData icon;
  final Color color;
  final double distanceKm;
  final String duration;
  final double rating;
  final int reviews;
  final bool open;
  final String? avatar;
  const _Place({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
    required this.distanceKm,
    required this.duration,
    required this.rating,
    required this.reviews,
    this.open = true,
    this.avatar,
  });
}

const _places = [
  _Place(name: 'Clinique Pasteur', category: 'Cliniques', icon: Icons.local_hospital_rounded, color: AppColors.info, distanceKm: 0.6, duration: '5 min', rating: 4.8, reviews: 128),
  _Place(name: 'Dr Amadou Keïta', category: 'Médecins', icon: Icons.medical_services_rounded, color: AppColors.primary, distanceKm: 0.8, duration: '6 min', rating: 4.9, reviews: 96, avatar: 'assets/images/avatar_amadou.png'),
  _Place(name: 'Pharmacie ACI 2000', category: 'Pharmacies', icon: Icons.local_pharmacy_rounded, color: AppColors.success, distanceKm: 1.2, duration: '4 min', rating: 4.7, reviews: 254),
  _Place(name: 'Laboratoire Santé+', category: 'Labs', icon: Icons.science_rounded, color: AppColors.warning, distanceKm: 1.5, duration: '5 min', rating: 4.6, reviews: 86),
  _Place(name: 'Clinique Médicale du Mali', category: 'Cliniques', icon: Icons.local_hospital_rounded, color: AppColors.info, distanceKm: 2.1, duration: '7 min', rating: 4.5, reviews: 74),
  _Place(name: 'Pharmacie du Fleuve', category: 'Pharmacies', icon: Icons.local_pharmacy_rounded, color: AppColors.success, distanceKm: 2.4, duration: '7 min', rating: 4.4, reviews: 53),
];

class _NearbyScreenState extends State<NearbyScreen> {
  String _category = 'Tous';
  bool _mapView = true;
  static const _categories = ['Tous', 'Cliniques', 'Médecins', 'Pharmacies', 'Labs'];

  List<_Place> get _filtered => _category == 'Tous' ? _places : _places.where((p) => p.category == _category).toList();

  @override
  Widget build(BuildContext context) {
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Autour de vous', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                        Text('Trouvez les services de santé près de vous', style: TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                      child: const Icon(Icons.tune_rounded, color: AppColors.primary, size: 19),
                    ),
                  ),
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
                  Expanded(child: Text('Rechercher un lieu, un professionnel...', style: TextStyle(color: AppColors.textMuted, fontSize: 12.5))),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final c = _categories[i];
                  final active = c == _category;
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => setState(() => _category = c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? AppColors.primary : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(c, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.textBody)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 110),
                children: [
                  Stack(
                    children: [
                      MapPlaceholder(height: _mapView ? 190 : 0, borderRadius: BorderRadius.circular(20)),
                      if (_mapView)
                        Positioned(
                          right: 10,
                          top: 10,
                          child: _toggleMapBtn(),
                        ),
                    ],
                  ),
                  if (_mapView) const SizedBox(height: 14),
                  if (!_mapView) _toggleMapBtn(alignRight: false),
                  if (!_mapView) const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: Row(
                      children: [
                        _statItem('12', 'Cliniques'),
                        _statItem('18', 'Médecins'),
                        _statItem('15', 'Pharmacies'),
                        _statItem('8', 'Laboratoires'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('${_filtered.length} résultats · Dans un rayon de 5 km', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  ..._filtered.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _PlaceRow(place: p, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceDetailScreen(name: p.name, category: p.category)))),
                      )),
                  Center(
                    child: OutlinedButton(onPressed: () {}, child: const Text('Voir plus de résultats')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleMapBtn({bool alignRight = true}) {
    final btn = InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => _mapView = !_mapView),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8)]),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(_mapView ? Icons.list_rounded : Icons.map_rounded, size: 16, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(_mapView ? 'Liste' : 'Carte', style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.primary)),
        ]),
      ),
    );
    return alignRight ? btn : Align(alignment: Alignment.centerLeft, child: btn);
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
          Text(label, style: const TextStyle(fontSize: 9.5, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _PlaceRow extends StatelessWidget {
  final _Place place;
  final VoidCallback onTap;
  const _PlaceRow({required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            if (place.avatar != null)
              CircleAvatar(radius: 22, backgroundImage: AssetImage(place.avatar!))
            else
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: place.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(place.icon, color: place.color, size: 20),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 13),
                    Text(' ${place.rating} (${place.reviews}) · ', style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
                    Text(place.open ? 'Ouvert' : 'Fermé', style: TextStyle(fontSize: 10.5, color: place.open ? AppColors.success : AppColors.danger, fontWeight: FontWeight.w700)),
                  ]),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${place.distanceKm} km', style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                Text(place.duration, style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
