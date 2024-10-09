import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishCard extends StatefulWidget {
  final String name;
  final int top;
  final double cost;
  final int weight;
  final String imageUrl;

  const DishCard({
    super.key,
    required this.name,
    required this.top,
    required this.imageUrl,
    required this.cost,
    required this.weight,
  });

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
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
              fit: BoxFit.cover,
              height: 300,
              width: 140,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 8, // Отступ сверху
            right: 8, // Отступ справа
            child: Container(
              height: 24,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 145, 18),
                borderRadius:
                    BorderRadius.circular(12), // Сделаем контейнер круглый
              ),
              child: Text(
                "Топ ${widget.top}",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
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
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(135, 135, 139, 0.95),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
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
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 5),
                      child: Row(
                        children: [
                          Text(
                            "${widget.cost} Br",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 3,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${widget.weight} гр",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
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
