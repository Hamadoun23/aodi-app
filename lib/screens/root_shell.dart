import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'home/home_screen.dart';
import 'appointments/appointments_screen.dart';
import 'nearby/nearby_screen.dart';
import 'messages/messages_screen.dart';
import 'profile/profile_screen.dart';

/// Coquille principale de l'application : gère les 5 onglets de la barre
/// de navigation inférieure (Accueil, Rendez-vous, Autour de vous,
/// Messages, Profil), conformément aux maquettes mobiles.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  void goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigate: goTo),
      AppointmentsScreen(onNavigate: goTo),
      NearbyScreen(onNavigate: goTo),
      const MessagesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNav(currentIndex: _index, onTap: goTo),
    );
  }
}
