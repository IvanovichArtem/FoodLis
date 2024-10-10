import 'package:flutter/material.dart';
import 'package:food_lis/widgets/kitchen_modal/bloger_reviews.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_best_dishes.dart';
import 'package:food_lis/widgets/kitchen_modal/switch_buttons.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomSheet extends StatefulWidget {
  final String name;
  final String imageUrl;

  const CustomBottomSheet({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool iconState = false; // Состояние для иконки

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Основной контейнер с содержимым
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.92,
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
                            const SwitchButtons(),
                            const SizedBox(height: 5),
                            // Имя + иконки
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          const Color.fromARGB(255, 48, 48, 48),
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
                            const RestarauntInfo(
                              restarauntType: 'Ресторан итальянской кухни',
                              rating_count: 105,
                              ratingMean: 4.5,
                              closingDate: '22:00',
                              meanCost: 24,
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
                        onPressed: () {
                          setState(() {
                            iconState = !iconState; // Меняем состояние
                          });
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

void showCustomBottomSheet(BuildContext context,
    {required String name, required String imageUrl}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomBottomSheet(name: name, imageUrl: imageUrl);
    },
  );
}
