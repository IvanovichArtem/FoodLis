import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestarauntCard extends StatefulWidget {
  final String name;
  final double rating;
  final int review_count;
  final String imageUrl;

  const RestarauntCard(
      {super.key,
      required this.name,
      required this.rating,
      required this.review_count,
      required this.imageUrl});

  @override
  State<RestarauntCard> createState() => _RestarauntCardState();
}

class _RestarauntCardState extends State<RestarauntCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 196,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(10)), // Добавьте радиус
            child: Image.asset(
              widget.imageUrl,
              width: 140,
              fit: BoxFit.cover,
              height: 300,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            bottom: 0, // Позиционирование снизу
            left: 0,
            right: 0,
            height: 48,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10)), // Добавьте радиус
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(135, 135, 139, 0.95),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 3, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            widget.rating.toString().replaceAll('.', ','),
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 1),
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.white,
                            size: 10,
                          ),
                          Text(
                            "  ${widget.review_count} отзыва",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
