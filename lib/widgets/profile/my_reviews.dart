import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  final List<Map<String, dynamic>> restaurantData = [
    {
      'name': 'Мамомимо',
      'review':
          "Отличное место, приятный интерьер, хороший персонал. Очень понравился салат с креветками, обязательно попробуйте",
      'rating': 5,
    },
    {
      'name': 'Мамомимо',
      'review':
          "Отличное место, приятный интерьер, хороший персонал. Очень понравился салат с креветками, обязательно попробуйте",
      'rating': 4,
    },
    {
      'name': 'Мамомимо',
      'review':
          "Отличное место, приятный интерьер, хороший персонал. Очень понравился салат с креветками, обязательно попробуйте",
      'rating': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Мои отзывы",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 48, 48, 48),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Все",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color.fromARGB(255, 114, 114, 114),
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 5, 0),
              child: Row(
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      Container(
                        width: 300,
                        height: 140,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 15, 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      restaurant['name'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 114, 114, 114),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  StarRating(
                                      rating: (restaurant['rating'].toDouble()))
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Center(
                                child: Divider(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  height: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(children: [
                                SizedBox(
                                  height: 89,
                                  width: 270,
                                  child: Text(
                                    restaurant['review'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: GoogleFonts.montserrat(
                                        color: const Color.fromARGB(
                                            255, 175, 175, 175),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                      if (index < restaurantData.length - 1)
                        const SizedBox(width: 8),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int roundedRating = rating.ceil();

    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.5),
          child: Icon(
            index < roundedRating
                ? FontAwesomeIcons.solidStar
                : FontAwesomeIcons.star,
            color: const Color.fromARGB(255, 229, 145, 18),
            size: 14,
          ),
        );
      }),
    );
  }
}
