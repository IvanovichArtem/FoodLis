import 'package:flutter/material.dart';
import 'package:food_lis/widgets/kitchen_modal/dish_card.dart';
import 'package:google_fonts/google_fonts.dart';

class RestarauntBestDishes extends StatefulWidget {
  const RestarauntBestDishes({super.key});

  @override
  State<RestarauntBestDishes> createState() => _RestarauntBestDishesState();
}

class _RestarauntBestDishesState extends State<RestarauntBestDishes> {
  List<Map<String, dynamic>> restaurantData = [
    {
      'name': 'Греческий салат',
      'top': 1,
      'cost': 25.0,
      'weight': 200,
      'imageUrl': 'assets/images/dishes/греческий салат.jpg',
    },
    {
      'name': 'Тигровые креветки',
      'top': 2,
      'cost': 25.0,
      'weight': 200,
      'imageUrl': 'assets/images/dishes/тигровые креветки.jpg',
    },
    {
      'name': 'Лосось',
      'top': 3,
      'cost': 25.0,
      'weight': 200,
      'imageUrl': 'assets/images/dishes/лосось.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Блюда",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 114, 114, 114)),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text("Меню",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 114, 114, 114))),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color.fromARGB(255, 114, 114, 114),
                      size: 14,
                    )
                  ],
                )
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
              padding: const EdgeInsets.fromLTRB(10, 8, 5, 0),
              child: Row(
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      DishCard(
                        name: restaurant['name'],
                        imageUrl: restaurant['imageUrl'],
                        top: restaurant['top'],
                        cost: restaurant['cost'],
                        weight: restaurant['weight'],
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
