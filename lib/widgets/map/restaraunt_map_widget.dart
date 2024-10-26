import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RestaurantMarkerPainter extends CustomPainter {
  final String name;
  final String rating;
  final String price;

  RestaurantMarkerPainter(
      {required this.name, required this.rating, required this.price});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final borderRadius = BorderRadius.circular(17);

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(17));
    canvas.drawRRect(rrect, paint);

    final textPainterName = TextPainter(
      text: TextSpan(
        text: name,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 244, 175, 17)),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainterName.layout(maxWidth: size.width - 12);
    textPainterName.paint(canvas, Offset(6, 7));

    final textPainterRating = TextPainter(
      text: TextSpan(
        text: rating + " ~ " + price + " Br",
        style:
            TextStyle(fontSize: 12, color: Color.fromARGB(255, 244, 175, 17)),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainterRating.layout(maxWidth: size.width - 12);
    textPainterRating.paint(canvas, Offset(28, 30));

    final starIcon = Icons.star_rounded;
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle());
    builder.pushStyle(ui.TextStyle(color: Color.fromARGB(255, 244, 175, 17)));
    builder.addText('\u{2605}'); // Символ звезды

    final paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 18));
    canvas.drawParagraph(paragraph, Offset(6, 30));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
