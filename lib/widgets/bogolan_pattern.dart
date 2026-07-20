import 'package:flutter/material.dart';

/// Motif géométrique discret inspiré du bogolan malien, utilisé en
/// filigrane sur les cartes violettes (identité visuelle AODI).
class BogolanPattern extends StatelessWidget {
  final Color color;
  final double opacity;

  const BogolanPattern({super.key, this.color = Colors.white, this.opacity = 0.08});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(
          painter: _BogolanPainter(color),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _BogolanPainter extends CustomPainter {
  final Color color;
  _BogolanPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    const step = 34.0;
    for (double y = -step; y < size.height + step; y += step) {
      for (double x = -step; x < size.width + step; x += step) {
        final offset = ((y / step).round() % 2 == 0) ? 0.0 : step / 2;
        final cx = x + offset;
        final path = Path()
          ..moveTo(cx, y - 8)
          ..lineTo(cx + 8, y)
          ..lineTo(cx, y + 8)
          ..lineTo(cx - 8, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BogolanPainter oldDelegate) => false;
}
