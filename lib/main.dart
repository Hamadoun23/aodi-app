import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/root_shell.dart';

void main() {
  runApp(const AodiApp());
}

class AodiApp extends StatelessWidget {
  const AodiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AODI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootShell(),
    );
  }
}
