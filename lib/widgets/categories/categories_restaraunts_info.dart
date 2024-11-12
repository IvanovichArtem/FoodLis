import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not authenticated');
        return;
      }

      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaraunts').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final storagePath = data['imageUrl'];
        if (storagePath.length == 0) {
          continue;
        }

        final downloadUrl =
            await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

        final userDocId = '${user.uid}_${doc.id}';
        final userRestDoc = await FirebaseFirestore.instance
            .collection('user_rest')
            .doc(userDocId)
            .get();
        bool isToogle;
        if (userRestDoc.exists) {
          isToogle = userRestDoc['isBookmarked'];
        } else {
          isToogle = false;
        }

        restaurantData.add({
          'restId': doc.id,
          'name': data['name'],
          'avgReview': data['avgReview'],
          'cntReviews': data['cntReviews'],
          'imageUrl': downloadUrl,
          'endTime': data['endTime'],
          'restarauntType': data['restarauntType'],
          'avgPrice': data['avgPrice'],
          'isToogle': isToogle,
        });
      }

      // Sort restaurants by rating (descending) and then by review count (descending)
      restaurantData.sort((a, b) {
        final ratingComparison = b['avgReview'].compareTo(a['avgReview']);
        if (ratingComparison != 0) {
          return ratingComparison;
        }
        return b['cntReviews'].compareTo(a['cntReviews']);
      });

      if (restaurantData.length > 5) {
        restaurantData = restaurantData.sublist(0, 5);
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

      // Сортируем блюда сначала по рейтингу (по убыванию), затем по количеству отзывов (по убыванию)
      dishData.sort((a, b) {
        final ratingComparison = b['rating'].compareTo(a['rating']);
        if (ratingComparison != 0) {
          return ratingComparison; // Если рейтинг не равен, сортируем только по рейтингу
        }
        return b['review_count'].compareTo(a[
            'review_count']); // Если рейтинги равны, сортируем по количеству отзывов
      });

      if (dishData.length > 5) {
        dishData = dishData.sublist(0, 5);
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
                children: restaurantData.asMap().entries.map((entry) {
                  final restaurant = entry.value;
                  final index = entry.key;

                  return Row(
                    children: [
                      RestarauntCard(
                        docId: restaurant['restId'],
                        name: restaurant['name'],
                        restarauntType: restaurant['restarauntType'],
                        avgReview: restaurant['avgReview'].toDouble(),
                        cntReviews: restaurant['cntReviews'],
                        imageUrl: restaurant['imageUrl'],
                        endTime: restaurant['endTime'],
                        timeByWalk: 5,
                        avgPrice: restaurant['avgPrice'],
                        isToogle: restaurant['isToogle'],
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
