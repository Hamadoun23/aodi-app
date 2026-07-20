/// Données de démonstration utilisées dans toute l'application AODI.
/// (Aucun backend n'est branché : ces données illustrent les maquettes.)
class Doctor {
  final String name;
  final String speciality;
  final String clinic;
  final String avatar;
  final double rating;
  final int reviews;
  final double distanceKm;
  final bool available;
  final bool onlineNow;

  const Doctor({
    required this.name,
    required this.speciality,
    required this.clinic,
    required this.avatar,
    required this.rating,
    required this.reviews,
    required this.distanceKm,
    this.available = true,
    this.onlineNow = false,
  });
}

const doctorAmadou = Doctor(
  name: 'Dr Amadou Keïta',
  speciality: 'Cardiologue',
  clinic: 'Clinique AODI Bamako',
  avatar: 'assets/images/avatar_amadou.png',
  rating: 4.9,
  reviews: 128,
  distanceKm: 0.3,
  onlineNow: true,
);

const doctorFatoumataDiallo = Doctor(
  name: 'Dr Fatoumata Diallo',
  speciality: 'Cardiologue',
  clinic: 'Clinique Pasteur',
  avatar: 'assets/images/avatar_fatoumata_diallo.png',
  rating: 4.8,
  reviews: 96,
  distanceKm: 0.6,
);

const doctorOumarTraore = Doctor(
  name: 'Dr Oumar Traoré',
  speciality: 'Cardiologue',
  clinic: 'Clinique du Cœur',
  avatar: 'assets/images/avatar_oumar_traore.png',
  rating: 4.7,
  reviews: 82,
  distanceKm: 1.1,
);

const doctorFatoumataSissoko = Doctor(
  name: 'Dr Fatoumata Sissoko',
  speciality: 'Dermatologue',
  clinic: 'Clinique ACI 2000',
  avatar: 'assets/images/avatar_fatoumata_sissoko.png',
  rating: 4.8,
  reviews: 74,
  distanceKm: 0.9,
);

const doctorMoussaTraore = Doctor(
  name: 'Dr Moussa Traoré',
  speciality: 'Médecin généraliste',
  clinic: 'Clinique AODI Bamako',
  avatar: 'assets/images/avatar_moussa_traore.png',
  rating: 4.6,
  reviews: 61,
  distanceKm: 0.5,
);

const List<Doctor> allDoctors = [
  doctorAmadou,
  doctorFatoumataDiallo,
  doctorOumarTraore,
  doctorFatoumataSissoko,
  doctorMoussaTraore,
];
