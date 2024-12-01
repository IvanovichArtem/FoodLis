import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_lis/widgets/categories/restaraunt_card.dart';
import 'package:food_lis/widgets/categories/dish_card.dart';
import 'package:food_lis/providers/data_provider.dart';

class PersonalizedInfoWidget extends StatefulWidget {
  final onAllRest;
  const PersonalizedInfoWidget({super.key, this.onAllRest});

  @override
  State<PersonalizedInfoWidget> createState() => _PersonalizedInfoWidgetState();
}

class _PersonalizedInfoWidgetState extends State<PersonalizedInfoWidget> {
  List<Map<String, dynamic>> dishData = [];
  List<Map<String, dynamic>> restaurantData = [];
  bool readyRest = false;

  @override
  void initState() {
    super.initState();

    // Добавляем задержку на 3 секунды после super.initState
    Future.delayed(const Duration(seconds: 3), () {
      // Получаем данные из Provider один раз
      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      restaurantData = dataProvider.restaurantData;

      // Загружаем блюда
      fetchDishData();
    });
  }

  // Метод для загрузки данных о блюдах
  Future<void> fetchDishData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('rest_dishes').get();

      for (var doc in querySnapshot.docs) {
        try {
          final data = doc.data();
          final storagePath = data['imageUrl'];

          final downloadUrl =
              await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

          // Проверяем, существует ли уже такое блюдо в списке
          if (!dishData.any((dish) => dish['name'] == data['name'])) {
            dishData.add({
              'name': data['name'],
              'restaraunt': data['restaraunt'],
              'rating': data['rating'],
              'review_count': data['reviewCount'],
              'imageUrl': downloadUrl,
            });
          }
        } catch (e) {
          // Логируем ошибку для конкретного документа, но продолжаем выполнение
          print('Error processing document ${doc.id}: $e');
        }
      }

      // Сортируем блюда по рейтингу и количеству отзывов
      dishData.sort((a, b) {
        final ratingComparison = b['rating'].compareTo(a['rating']);
        if (ratingComparison != 0) {
          return ratingComparison;
        }
        return b['review_count'].compareTo(a['review_count']);
      });

      // Ограничиваем количество блюд до 5
      if (dishData.length > 5) {
        dishData = dishData.sublist(0, 5);
      }

      setState(() {
        dishData = dishData;
      });
    } catch (e) {
      print('Error fetching dish data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedRestaurants = List.from(restaurantData)
      ..sort((a, b) {
        final ratingComparison = b['avgReview'].compareTo(a['avgReview']);
        if (ratingComparison != 0) {
          return ratingComparison;
        }
        return b['cntReviews'].compareTo(a['cntReviews']);
      });

    // Проверяем, есть ли уже 5 ресторанов
    if (sortedRestaurants.length > 5) {
      sortedRestaurants = sortedRestaurants.sublist(0, 5);
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          // Отображение ресторанов
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Рестораны",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 138, 138, 142),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.onAllRest();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Все",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(255, 138, 138, 142),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color.fromARGB(255, 138, 138, 142),
                        size: 12,
                      ),
                    ],
                  ),
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
                children: sortedRestaurants.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      RestarauntCard(
                        docId: restaurant['id'],
                        name: restaurant['name'],
                        restarauntType: restaurant['restarauntType'],
                        avgReview: restaurant['avgReview'].toDouble(),
                        cntReviews: restaurant['cntReviews'],
                        imageUrl: restaurant['imageUrl'],
                        endTime: restaurant['endTime'],
                        timeByWalk: 5,
                        avgPrice: restaurant['avgPrice'],
                        isToogle: restaurant['isToogle'],
                        videoUrl: restaurant['videoUrl'],
                        instaUrl: restaurant['instaUrl'],
                        siteUrl: restaurant['siteUrl'],
                      ),
                      if (index < sortedRestaurants.length - 1)
                        const SizedBox(width: 8),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Отображение блюд
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Блюда",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 138, 138, 142),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Все",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 138, 138, 142),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color.fromARGB(255, 138, 138, 142),
                      size: 12,
                    ),
                  ],
                ),
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
                      if (index < dishData.length - 1) const SizedBox(width: 8),
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
