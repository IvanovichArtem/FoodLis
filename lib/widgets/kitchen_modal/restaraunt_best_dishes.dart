import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_lis/widgets/kitchen_modal/dish_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dishes_menu.dart';

class RestarauntBestDishes extends StatefulWidget {
  final String restarauntId; // Передаем id ресторана через конструктор

  const RestarauntBestDishes({super.key, required this.restarauntId});

  @override
  State<RestarauntBestDishes> createState() => _RestarauntBestDishesState();
}

class _RestarauntBestDishesState extends State<RestarauntBestDishes> {
  List<Map<String, dynamic>> restaurantData = [];
  bool isLoading = true;
  List _dishes = [];

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  Future<void> loadDishes() async {
    try {
      final restaurantDoc = await FirebaseFirestore.instance
          .collection('restaraunts')
          .doc(widget.restarauntId)
          .get();

      if (restaurantDoc.exists) {
        List<dynamic> dishesIds = restaurantDoc['dishes_id'];
        List<Map<String, dynamic>> dishes = [];

        for (var dishId in dishesIds) {
          try {
            final dishDoc = await FirebaseFirestore.instance
                .collection('rest_dishes')
                .doc(dishId)
                .get();

            if (dishDoc.exists) {
              final imageUrl = await FirebaseStorage.instance
                  .ref(dishDoc['imageUrl'])
                  .getDownloadURL();

              dishes.add({
                'name': dishDoc['name'],
                'cost': dishDoc['price'],
                'weight': dishDoc['weight'],
                'rating': dishDoc['rating'], // добавляем рейтинг
                'imageUrl': imageUrl,
              });
            }
          } catch (e) {
            // Игнорируем ошибки при загрузке конкретного блюда
            debugPrint('Ошибка загрузки блюда с id $dishId: $e');
          }
        }

        // Сортировка по рейтингу и выбор топ-3
        dishes.sort(
            (a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        _dishes = dishes;
        final topDishes = dishes.take(3).toList();

        setState(() {
          restaurantData = topDishes;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Ошибка загрузки данных ресторана: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 244, 160, 15))),
      );
    }

    if (restaurantData.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
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
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DishesMenu(menuItems: _dishes),
                          ),
                        )
                      },
                      child: Text("Меню",
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 114, 114, 114))),
                    ),
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
          const Divider(
            indent: 15,
            endIndent: 15,
            height: 1,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 5, 0),
              child: Row(
                children: [
                  {
                    "name": "Свиная рулька 'Швайнхаксе'",
                    "cost": 45,
                    "weight": 490,
                    "rating": 4.8,
                    "imageUrl":
                        "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D1%88%D0%B2%D0%B0%D0%B9%D0%BD%D1%85%D0%B0%D0%BA%D1%81%D0%B5.jpg?alt=media&token=666e4825-72c6-45ab-a676-1af01e4ee669"
                  },
                  {
                    "name": "Антипасто",
                    "cost": 45,
                    "weight": 530,
                    "rating": 4.4,
                    "imageUrl":
                        "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%B0%D0%BD%D1%82%D0%B8%D0%BF%D0%B0%D1%81%D1%82%D0%BE.jpg?alt=media&token=e13d6005-0183-4035-9f93-5e14d6c08880"
                  },
                  {
                    "name": "Закуска 'Октоберфест'",
                    "cost": 65,
                    "weight": 1000,
                    "rating": 4.3,
                    "imageUrl":
                        "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%BE%D0%BA%D1%82%D0%BE%D0%B1%D0%B5%D1%80%D1%84%D0%B5%D1%81%D1%82.jpg?alt=media&token=0abfb2bc-c88e-4412-ac28-2d2ed33149f4"
                  }
                ].asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0), // Добавлен отступ между карточками
                    child: DishCard(
                      name: restaurant['name'].toString(),
                      imageUrl: restaurant['imageUrl'].toString(),
                      top: index + 1,
                      cost: (restaurant['cost'] as num?)?.toDouble() ?? 0.0,
                      weight: (restaurant['weight'] as num?)?.toInt() ?? 0,
                      rating: (restaurant['rating'] as num?)?.toDouble() ?? 0.0,
                      width: 160,
                      height: 200,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
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
                  TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DishesMenu(menuItems: [
                            {
                              "name": "Свиная рулька 'Швайнхаксе'",
                              "cost": 45,
                              "weight": 490,
                              "rating": 4.8,
                              "imageUrl":
                                  "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D1%88%D0%B2%D0%B0%D0%B9%D0%BD%D1%85%D0%B0%D0%BA%D1%81%D0%B5.jpg?alt=media&token=666e4825-72c6-45ab-a676-1af01e4ee669"
                            },
                            {
                              "name": "Антипасто",
                              "cost": 45,
                              "weight": 530,
                              "rating": 4.4,
                              "imageUrl":
                                  "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%B0%D0%BD%D1%82%D0%B8%D0%BF%D0%B0%D1%81%D1%82%D0%BE.jpg?alt=media&token=e13d6005-0183-4035-9f93-5e14d6c08880"
                            },
                            {
                              "name": "Закуска 'Октоберфест'",
                              "cost": 65,
                              "weight": 1000,
                              "rating": 4.3,
                              "imageUrl":
                                  "https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%BE%D0%BA%D1%82%D0%BE%D0%B1%D0%B5%D1%80%D1%84%D0%B5%D1%81%D1%82.jpg?alt=media&token=0abfb2bc-c88e-4412-ac28-2d2ed33149f4"
                            }
                          ]),
                        ),
                      )
                    },
                    child: Text("Меню",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
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
        const Divider(
          indent: 15,
          endIndent: 15,
          height: 1,
          color: Color.fromARGB(255, 235, 235, 235),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 5, 0),
            child: Row(
              children: restaurantData.asMap().entries.map((entry) {
                final restaurant = entry.value;
                final index = entry.key;

                return Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0), // Добавлен отступ между карточками
                  child: DishCard(
                    name: restaurant['name'],
                    imageUrl: restaurant['imageUrl'],
                    top: index + 1,
                    cost: restaurant['cost'].toDouble(),
                    weight: restaurant['weight'],
                    rating: restaurant['rating'],
                    width: 160,
                    height: 200,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
