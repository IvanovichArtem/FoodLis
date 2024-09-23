import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_lis/widgets/categories/restaraunt_card.dart';
import 'package:food_lis/widgets/categories/dish_card.dart';

class PersonalizedInfoWidget extends StatefulWidget {
  const PersonalizedInfoWidget({super.key});

  @override
  State<PersonalizedInfoWidget> createState() => _PersonalizedInfoWidgetState();
}

class _PersonalizedInfoWidgetState extends State<PersonalizedInfoWidget> {
  List<Map<String, dynamic>> restaurantData = [
    {
      'name': 'У Веры',
      'rating': 4.2,
      'review_count': 64,
      'imageUrl': 'assets/images/restaraunts/у веры.jpg',
    },
    {
      'name': 'Greeny',
      'rating': 4.3,
      'review_count': 38,
      'imageUrl': 'assets/images/restaraunts/greeny.jpg',
    },
    {
      'name': 'Проспект',
      'rating': 5.0,
      'review_count': 12,
      'imageUrl': 'assets/images/restaraunts/Проспект.jpg',
    },
  ];

  List<Map<String, dynamic>> dishData = [
    {
      'name': 'Перепелка',
      'restaraunt': 'Мамомимо',
      'rating': 4.2,
      'review_count': 8,
      'imageUrl': 'assets/images/dishes/перепелка.jpg',
    },
    {
      'name': 'Курица с красной смородиной',
      'restaraunt': 'Prime',
      'rating': 4.3,
      'review_count': 4,
      'imageUrl': 'assets/images/dishes/курица.jpg',
    },
    {
      'name': 'Шакшука',
      'restaraunt': 'Мимино',
      'rating': 4.5,
      'review_count': 11,
      'imageUrl': 'assets/images/dishes/шакшука.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          // Рестораны
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Рестораны",
                  style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 138, 138, 142)),
                ),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Все",
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 138, 138, 142)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color.fromARGB(255, 138, 138, 142),
                    size: 12,
                  )
                ])
              ],
            ),
          ),
          const Center(
            child: Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Color.fromARGB(255, 235, 235, 235),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  10, 8, 5, 0), // Укажите нужные отступы
              child: Row(
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      RestarauntCard(
                        name: restaurant['name'],
                        rating: restaurant['rating'],
                        review_count: restaurant['review_count'],
                        imageUrl: restaurant['imageUrl'],
                      ),
                      // Добавляем расстояние между элементами, кроме последнего
                      if (index < restaurantData.length - 1)
                        const SizedBox(width: 8), // Расстояние между элементами
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          //Блюда
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Блюда",
                  style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 138, 138, 142)),
                ),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Все",
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 138, 138, 142)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color.fromARGB(255, 138, 138, 142),
                    size: 12,
                  )
                ])
              ],
            ),
          ),
          const Center(
            child: Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Color.fromARGB(255, 235, 235, 235),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  10, 8, 5, 0), // Укажите нужные отступы
              child: Row(
                children: dishData.asMap().entries.map((entry) {
                  final dish = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      DishCard(
                        name: dish['name'],
                        restaraunt: dish['restaraunt'],
                        rating: dish['rating'],
                        review_count: dish['review_count'],
                        imageUrl: dish['imageUrl'],
                      ),
                      // Добавляем расстояние между элементами, кроме последнего
                      if (index < restaurantData.length - 1)
                        const SizedBox(width: 8), // Расстояние между элементами
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
