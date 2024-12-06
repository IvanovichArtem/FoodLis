import 'package:flutter/material.dart';
import 'package:food_lis/widgets/kitchen_modal/bloger_reviews.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_best_dishes.dart';
import 'package:food_lis/widgets/kitchen_modal/switch_buttons.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_lis/widgets/booking/booking.dart';

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
  final String videoUrl;
  final String siteUrl;
  final String instaUrl;

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
    required this.videoUrl,
    required this.siteUrl,
    required this.instaUrl,
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
    // Используем размеры экрана для адаптивности
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Отступы и размеры на основе экрана
    final horizontalPadding = screenWidth * 0.05; // 5% от ширины экрана
    final imageHeight = screenHeight * 0.3; // 30% от высоты экрана
    final buttonWidth = screenWidth * 0.6; // 60% от ширины экрана
    final iconSize = screenWidth * 0.06; // 6% от ширины экрана

    return Stack(
      children: [
        // Основной контейнер с содержимым
        Container(
          width: double.infinity,
          height: screenHeight * 0.77, // 77% от высоты экрана
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Изображение ресторана
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: imageHeight, // Высота изображения
                          ),
                        ),
                        SizedBox(
                            height: screenHeight * 0.02), // 2% от высоты экрана
                        Column(
                          children: [
                            // Имя + иконки
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01,
                                  horizontal: horizontalPadding),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth *
                                        0.4, // 40% от ширины экрана
                                    child: Text(
                                      widget.name,
                                      maxLines: 2,
                                      style: GoogleFonts.montserrat(
                                        fontSize: screenWidth * 0.05,
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
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        "${(widget.timeByWalk / 5).toInt()} мин",
                                        style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 193, 193, 193),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.personWalking,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        "${widget.timeByWalk} мин",
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding * 0.0),
                              child: Row(
                                children: [
                                  Spacer(),
                                  RestarauntInfo(
                                    restarauntType: widget.restarauntType,
                                    rating_count: widget.cntReviews,
                                    ratingMean: widget.avgReview,
                                    closingDate: widget.endTime,
                                    meanCost: widget.avgPrice,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: RestarauntBestDishes(
                                restarauntId: widget.id,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: BlogerReviews(
                                name: widget.name,
                                siteUrl: widget.siteUrl,
                                videoUrl: widget.videoUrl,
                                instaUrl: widget.instaUrl,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Кнопки внизу
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Booking(
                                restId: widget.id,
                              ), // Новый экран, куда нужно перейти
                            ),
                          )
                        },
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
                          width: buttonWidth,
                          child: Center(
                            child: Text(
                              "Забронировать стол",
                              style: GoogleFonts.montserrat(
                                fontSize:
                                    screenWidth * 0.04, // 4% от ширины экрана
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
                              ? Color.fromARGB(255, 244, 160, 15)
                              : const Color.fromARGB(255, 175, 175, 175),
                          size: iconSize, // Адаптивный размер иконки
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
          top: screenHeight * 0.01, // 1% от высоты экрана
          left: screenWidth / 2 - 20, // Центрируем по горизонтали
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
    required bool isToogle,
    required String videoUrl,
    required String instaUrl,
    required String siteUrl}) {
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
          videoUrl: videoUrl,
          siteUrl: siteUrl,
          instaUrl: instaUrl);
    },
  );
}
