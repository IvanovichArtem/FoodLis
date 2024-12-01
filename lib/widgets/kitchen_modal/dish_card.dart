import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DishCard extends StatefulWidget {
  final String name;
  final int top;
  final double cost;
  final int weight;
  final String imageUrl;
  final double width;
  final double height;
  final double rating;

  const DishCard({
    super.key,
    required this.name,
    required this.top,
    required this.imageUrl,
    required this.cost,
    required this.weight,
    this.width = 140,
    this.height = 196,
    required this.rating,
  });

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit
                  .cover, // Изображение будет растягиваться на весь контейнер
              width: widget.width, // Используйте ширину контейнера
              height: widget.height, // Используйте высоту контейнера
              alignment: Alignment.center,
            ),
          ),
          widget.top != -1
              ? Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 24,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 229, 145, 18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Топ ${widget.top}",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 75,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                      child: Row(
                        children: [
                          Container(
                            height: 43,
                            width: widget.width,
                            child: Text(
                              widget.name,
                              maxLines: 2,
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
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.weight} гр",
                            style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 143, 143, 143),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.circle,
                            size: 2,
                            color: Color.fromARGB(255, 143, 143, 143),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${widget.rating}".replaceAll('.', ','),
                            style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 143, 143, 143),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 0, 0, 2),
                            child: FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: const Color.fromARGB(255, 229, 145, 18),
                              size: 11,
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.orange, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 3),
                              child: Text(
                                "${widget.cost.toInt()} Br",
                                style: GoogleFonts.montserrat(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
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
