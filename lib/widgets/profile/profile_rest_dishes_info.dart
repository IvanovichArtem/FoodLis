import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_lis/widgets/profile/restaraunt_rating_card.dart';
import 'package:food_lis/widgets/profile/dish_rating_card.dart';

class ProfileRestDishInfo extends StatefulWidget {
  const ProfileRestDishInfo({super.key});

  @override
  State<ProfileRestDishInfo> createState() => _ProfileRestDishInfoState();
}

class _ProfileRestDishInfoState extends State<ProfileRestDishInfo> {
  List<Map<String, dynamic>> restaurantData = [
    {
      'name': 'Мамомимо',
      'rating': 5.0,
      'top': 1,
      'imageUrl': 'assets/images/restaraunts/мамомимо.jpg',
    },
    {
      'name': 'Престиж',
      'rating': 5.0,
      'top': 2,
      'imageUrl': 'assets/images/restaraunts/престиж.jpg',
    },
    {
      'name': 'Проспект',
      'rating': 5.0,
      'top': 3,
      'imageUrl': 'assets/images/restaraunts/Проспект.jpg',
    },
  ];

  List<Map<String, dynamic>> dishData = [
    {
      'name': 'Греческий салат',
      'restaraunt': 'Мамомимо',
      'rating': 5.0,
      'top': 1,
      'imageUrl': 'assets/images/dishes/греческий салат.jpg',
    },
    {
      'name': 'Тигровые креветки',
      'restaraunt': 'Prime',
      'rating': 5.0,
      'top': 2,
      'imageUrl': 'assets/images/dishes/тигровые креветки.jpg',
    },
    {
      'name': 'Лосось',
      'restaraunt': 'Мимино',
      'rating': 5.0,
      'top': 3,
      'imageUrl': 'assets/images/dishes/лосось.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          // Рестораны
          Padding(
            padding: EdgeInsets.fromLTRB(15, 12, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Рестораны",
                  style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 138, 138, 142)),
                ),
                Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 138, 138, 142),
                    size: 18,
                  )
                ])
              ],
            ),
          ),
          Center(
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
              padding: const EdgeInsets.fromLTRB(10, 8, 5, 0),
              child: Row(
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      RestarauntRatingCard(
                        name: restaurant['name'],
                        rating: restaurant['rating'] ?? 5.0,
                        top: restaurant['top'],
                        imageUrl: restaurant['imageUrl'],
                      ),
                      // Добавляем расстояние между элементами, кроме последнего
                      if (index < restaurantData.length - 1)
                        SizedBox(width: 8), // Расстояние между элементами
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          //Блюда
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Блюда",
                  style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 138, 138, 142)),
                ),
                Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 138, 138, 142),
                    size: 18,
                  )
                ])
              ],
            ),
          ),
          Center(
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
                      DishRatingCard(
                        name: dish['name'],
                        restaraunt: dish['restaraunt'],
                        rating: dish['rating'],
                        top: dish['top'],
                        imageUrl: dish['imageUrl'],
                      ),
                      // Добавляем расстояние между элементами, кроме последнего
                      if (index < restaurantData.length - 1)
                        SizedBox(width: 8), // Расстояние между элементами
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
