import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_lis/widgets/categories/restaraunt_card.dart';
import 'package:food_lis/widgets/categories/dish_card.dart';

class PersonalizedInfoWidget extends StatefulWidget {
  const PersonalizedInfoWidget({super.key});

  @override
  State<PersonalizedInfoWidget> createState() => _PersonalizedInfoWidgetState();
}

class _PersonalizedInfoWidgetState extends State<PersonalizedInfoWidget> {
  List<Map<String, dynamic>> restaurantData = [];
  List<Map<String, dynamic>> dishData = []; // Placeholder for dish data

  @override
  void initState() {
    super.initState();
    fetchRestaurantData();
    fetchDishData();
  }

  Future<void> fetchRestaurantData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaraunts').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final storagePath = data['imageUrl'];

        final downloadUrl =
            await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

        restaurantData.add({
          'name': data['name'],
          'rating': data['avgReview'],
          'review_count': data['cntReviews'],
          'imageUrl': downloadUrl,
        });
      }

      setState(() {});
    } catch (e) {
      print('Error fetching restaurant data: $e');
    }
  }

  Future<void> fetchDishData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('dishes').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final storagePath = data['imageUrl'];

        final downloadUrl =
            await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

        dishData.add({
          'name': data['name'],
          'restaraunt': data['restaraunt'],
          'rating': data['rating'],
          'review_count': data['reviewCount'],
          'imageUrl': downloadUrl,
        });
      }

      setState(() {});
    } catch (e) {
      print('Error fetching dish data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
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
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      RestarauntCard(
                        name: restaurant['name'],
                        rating: restaurant['rating'].toDouble(),
                        reviewCount: restaurant['review_count'],
                        imageUrl: restaurant['imageUrl'],
                      ),
                      if (index < restaurantData.length - 1)
                        const SizedBox(width: 8),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Additional widgets, like dish data, can be added here
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Блюда",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
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
