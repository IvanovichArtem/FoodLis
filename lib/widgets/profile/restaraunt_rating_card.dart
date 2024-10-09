import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestarauntRatingCard extends StatefulWidget {
  final String name;
  final double rating;
  final int top;
  final String imageUrl;

  const RestarauntRatingCard(
      {super.key,
      required this.name,
      required this.rating,
      required this.top,
      required this.imageUrl});

  @override
  State<RestarauntRatingCard> createState() => _RestarauntRatingCardState();
}

class _RestarauntRatingCardState extends State<RestarauntRatingCard> {
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
            height: 49,
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
                              style: GoogleFonts.montserrat(
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
                            "Топ ${widget.top} - ${widget.rating.toString().replaceAll('.', ',')}",
                            style: GoogleFonts.montserrat(
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
