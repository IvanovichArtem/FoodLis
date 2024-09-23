import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KitchenItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double height;
  final double width;

  const KitchenItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10), // Устанавливаем радиус границ
        child: Image(
          image: AssetImage(imageUrl),
          width: width,
          height: height,
        ),
      ),
      Text(
        name,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    ]);
  }
}
