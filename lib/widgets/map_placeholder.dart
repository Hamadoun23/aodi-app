import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Représentation stylisée d'une carte (aucun SDK cartographique n'est
/// branché) : sert de fond décoratif cohérent avec les maquettes pour les
/// écrans de géolocalisation.
class MapPlaceholder extends StatelessWidget {
  final List<MapPin> pins;
  final double height;
  final BorderRadius? borderRadius;

  const MapPlaceholder({
    super.key,
    this.pins = const [
      MapPin(Alignment(-0.5, -0.7), AppColors.info, Icons.local_hospital_rounded),
      MapPin(Alignment(0.6, -0.3), AppColors.primary, Icons.medical_services_rounded),
      MapPin(Alignment(0.75, 0.6), AppColors.warning, Icons.science_rounded),
      MapPin(Alignment(-0.7, 0.5), AppColors.success, Icons.local_pharmacy_rounded),
    ],
    this.height = 170,
    this.borderRadius,
  });

  const MapPlaceholder.pins(this.pins, {super.key, this.height = 170, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: const Color(0xFFEFEAF8)),
            CustomPaint(painter: _GridPainter()),
            for (final pin in pins)
              Align(
                alignment: pin.alignment,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: pin.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [BoxShadow(color: pin.color.withValues(alpha: 0.4), blurRadius: 8)],
                  ),
                  child: Icon(pin.icon, color: Colors.white, size: 14),
                ),
              ),
            const Align(
              alignment: Alignment.center,
              child: _PulsingDot(),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPin {
  final Alignment alignment;
  final Color color;
  final IconData icon;
  const MapPin(this.alignment, this.color, this.icon);
}

class _PulsingDot extends StatelessWidget {
  const _PulsingDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.25),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: AppColors.info,
          shape: BoxShape.circle,
          border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    const step = 22.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final riverPaint = Paint()
      ..color = AppColors.info.withValues(alpha: 0.10)
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(-10, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.5, size.width + 10, size.height * 0.75);
    canvas.drawPath(path, riverPaint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}
