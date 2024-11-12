import 'package:flutter/material.dart';
import 'package:food_lis/widgets/kitchen_modal/bloger_reviews.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_best_dishes.dart';
import 'package:food_lis/widgets/kitchen_modal/switch_buttons.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomBottomSheet extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String restarauntType;
  final String endTime;
  final double avgReview;
  final int cntReviews;
  final int timeByWalk;
  final int avgPrice;
  final bool isToogle;
  final String id;

  const CustomBottomSheet({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.restarauntType,
    required this.endTime,
    required this.avgReview,
    required this.cntReviews,
    required this.timeByWalk,
    required this.avgPrice,
    required this.isToogle,
    required this.id,
  });

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool iconState = false; // Состояние для иконки

  @override
  void initState() {
    super.initState();
    iconState = widget.isToogle; // Инициализируем текущее состояние
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Основной контейнер с содержимым
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.77,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Изображение ресторана
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: 250, // Высота изображения
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: Column(
                          children: [
                            // const SwitchButtons(),
                            const SizedBox(height: 5),
                            // Имя + иконки
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(
                                            255, 48, 48, 48),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.car,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "5 мин",
                                        style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 193, 193, 193),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.personWalking,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "20 мин",
                                        style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 193, 193, 193),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            RestarauntInfo(
                              restarauntType: widget.restarauntType,
                              rating_count: widget.cntReviews,
                              ratingMean: widget.avgReview,
                              closingDate: widget.endTime,
                              meanCost: widget.avgPrice,
                            ),
                            const RestarauntBestDishes(),
                            const BlogerReviews(
                              name: "mamomimo",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Кнопки внизу
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 243, 175, 79),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 243, 175, 79),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: SizedBox(
                          width: 220,
                          child: Center(
                            child: Text(
                              "Забронировать стол",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;

                          if (user == null) {
                            print('User not authenticated');
                            return;
                          }

                          final docId = '${user.uid}_${widget.id}';
                          final docRef = FirebaseFirestore.instance
                              .collection('user_rest')
                              .doc(docId);

                          try {
                            final docSnapshot = await docRef.get();

                            setState(() {
                              iconState = !iconState; // Toggle the state
                            });

                            if (docSnapshot.exists) {
                              // Update the existing document
                              await docRef.update({'isToogle': iconState});
                            } else {
                              // Create a new document
                              await docRef.set({
                                'isBookmarked': iconState,
                                'userId': user.uid,
                                'restId': widget.id,
                                // Add other fields as needed
                              });
                            }
                          } catch (e) {
                            print('Error updating document: $e');
                          }
                        },
                        icon: Icon(
                          iconState
                              ? Icons.bookmark
                              : Icons.bookmark_border_rounded,
                          color: iconState
                              ? Colors.orange
                              : const Color.fromARGB(255, 175, 175, 175),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Черная фигнюшка сверху
        Positioned(
          top: 5, // Позиция сверху
          left: MediaQuery.of(context).size.width / 2 -
              20, // Центрируем по горизонтали
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

void showRestBottomSheet(BuildContext context,
    {required String restId,
    required String name,
    required String imageUrl,
    required String restarauntType,
    required String endTime,
    required double avgReview,
    required int cntReviews,
    required int timeByWalk,
    required int avgPrice,
    required bool isToogle}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        id: restId,
        name: name,
        imageUrl: imageUrl,
        restarauntType: restarauntType,
        endTime: endTime,
        avgReview: avgReview,
        cntReviews: cntReviews,
        timeByWalk: timeByWalk,
        avgPrice: avgPrice,
        isToogle: isToogle,
      );
    },
  );
}
