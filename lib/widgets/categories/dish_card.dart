import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DishCard extends StatefulWidget {
  final String name;
  final String restaraunt;
  final double rating;
  final int review_count;
  final String imageUrl;

  const DishCard({
    super.key,
    required this.name,
    required this.rating,
    required this.review_count,
    required this.imageUrl,
    required this.restaraunt,
  });

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  String getReviewWord(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return "$count отзыв";
    } else if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return "$count отзыва";
    } else {
      return "$count отзывов";
    }
  }

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
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              height: 300,
              width: 140,
              alignment: Alignment.topCenter,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 243, 175, 79),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 0, // Позиционирование снизу
            left: 0,
            right: 0,
            height: 64,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10)), // Добавьте радиус
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: Color.fromARGB(255, 235, 235, 235))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            widget.restaraunt,
                            style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 191, 191, 191),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            widget.rating.toString().replaceAll('.', ','),
                            style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 114, 114, 114),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 1),
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.orange,
                            size: 10,
                          ),
                          Text(
                            "  ${getReviewWord(widget.review_count)}",
                            style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 114, 114, 114),
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
