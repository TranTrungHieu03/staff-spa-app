import 'package:flutter/cupertino.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class ScannerOverlayPainter extends CustomPainter {
  final Rect scanWindow;
  final double scanLinePercent;

  ScannerOverlayPainter(this.scanWindow, {required this.scanLinePercent});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = TColors.black.withOpacity(0.7);

    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(scanWindow)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(backgroundPath, backgroundPaint);

    final borderPaint = Paint()
      ..color = TColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRect(scanWindow, borderPaint);

    final scanLineY = scanWindow.top + scanLinePercent * scanWindow.height;

    final scanLinePaint = Paint()
      ..color = TColors.primary.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(scanWindow.left, scanLineY, scanWindow.width, 3.0),
      scanLinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanLinePercent != scanLinePercent || oldDelegate.scanWindow != scanWindow;
  }
}
