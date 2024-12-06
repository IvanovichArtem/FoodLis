import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Замените этим классом или импортируйте DishFullCard
class DishFullCard extends StatefulWidget {
  final String name;
  final int top;
  final double cost;
  final int weight;
  final String imageUrl;
  final double rating;
  static Color greyDark = Color.fromARGB(255, 48, 48, 48);
  static Color greyMedium = Color.fromARGB(255, 114, 114, 114);
  static Color greyBg = Color.fromARGB(255, 247, 247, 247);
  static Color greyDiv = Color.fromARGB(255, 235, 235, 235);
  static Color greyLight = Color.fromARGB(255, 175, 175, 175);
  static Color main = Color.fromARGB(255, 244, 160, 15);

  const DishFullCard({
    super.key,
    required this.name,
    required this.top,
    required this.imageUrl,
    required this.cost,
    required this.weight,
    required this.rating,
  })  : reviewCount = 25,
        reviewFullCount = 105;

  final int reviewCount;
  final int reviewFullCount;

  @override
  State<DishFullCard> createState() => _DishFullCardState();
}

class _DishFullCardState extends State<DishFullCard> {
  String username = "";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<String> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            username = userDoc['name'] ?? 'Unknown';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
    return 'Unknown';
  }

  String getRatingWord(int count, List<String> words) {
    if (count % 10 == 1 && count % 100 != 11) {
      return "$count ${words[0]}";
    } else if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return "$count ${words[1]}";
    } else {
      return "$count ${words[2]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Text(
                widget.name,
                style: GoogleFonts.montserrat(
                    color: DishFullCard.greyDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: DishFullCard.greyBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Описание которое пока кто-то съел",
                  style: GoogleFonts.montserrat(
                      color: DishFullCard.greyMedium, fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: DishFullCard.greyBg,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.rating.toString().replaceAll('.', ','),
                          style: GoogleFonts.montserrat(
                              color: DishFullCard.greyDark,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star,
                          color: DishFullCard.main,
                          size: 25,
                        ),
                        Column(
                          children: [
                            Text(
                              getRatingWord(widget.reviewFullCount,
                                  ['оценка', 'оценки', 'оценок']),
                              style: GoogleFonts.montserrat(
                                  color: DishFullCard.greyDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              getRatingWord(widget.reviewCount,
                                  ['отзыв', 'отзыва', 'отзывов']),
                              style: GoogleFonts.montserrat(
                                  color: DishFullCard.greyDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: DishFullCard.greyBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "${widget.weight} гр",
                          style: GoogleFonts.montserrat(
                              color: DishFullCard.greyMedium, fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: DishFullCard.main, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '${widget.cost.toInt()} Br',
                          style: GoogleFonts.montserrat(
                              color: DishFullCard.main,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            // Отзыв
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                decoration: BoxDecoration(
                    border: Border.all(color: DishFullCard.greyDiv),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                      child: Row(
                        children: [
                          Text(
                            username,
                            style: GoogleFonts.montserrat(
                                color: DishFullCard.greyMedium,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          StarRatingWidget(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        height: 1,
                        color: DishFullCard.greyDiv,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          border: Border.all(color: DishFullCard.greyDiv),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 230,
                            child: TextField(
                              cursorColor: DishFullCard.greyLight,
                              style: GoogleFonts.montserrat(
                                  color: DishFullCard.greyLight),
                              decoration: InputDecoration(
                                hintText: 'Комментарий',
                                hintStyle: GoogleFonts.montserrat(
                                    color: DishFullCard.greyLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            highlightColor: DishFullCard.greyLight,
                            onPressed: () => {},
                            icon: Transform.rotate(
                              angle: -90 *
                                  3.14159 /
                                  180, // Преобразуем градусы в радианы
                              child: Icon(Icons.attachment,
                                  color: DishFullCard.greyLight, size: 30),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  Text(
                    "Фото и видео",
                    style: GoogleFonts.montserrat(
                        color: DishFullCard.greyDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Spacer(),
                  // TextButton(
                  //   onPressed: () => {},
                  //   style: TextButton.styleFrom(
                  //     padding: EdgeInsets.zero, // Убираем отступы
                  //   ),
                  //   child: Row(
                  //     mainAxisSize:
                  //         MainAxisSize.min, // Уменьшаем размер Row до минимума
                  //     children: [
                  //       Text(
                  //         "Все",
                  //         style: GoogleFonts.montserrat(
                  //           color: greyMedium,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       SizedBox(width: 5),
                  //       Transform.rotate(
                  //         angle: 180 * 3.14159 / 180,
                  //         child: Icon(Icons.arrow_back_ios,
                  //             color: greyMedium, size: 14),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Builder(
                  builder: (context) {
                    // Пример списка данных (можно заменить на ваш список)
                    List<String> imageList = [
                      'https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%B3%D0%BE%D0%B2%D1%8F%D0%B4%D0%B8%D0%BD%D0%B0%20%D0%BA%D0%B8%D1%81%D0%BB.jpg?alt=media&token=a330644d-3800-487f-83fd-cf22ce09e854',
                      'https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%BA%D1%83%D1%80%D0%B8%D1%86%D0%B0.jpg?alt=media&token=0973cc0f-e3ae-4df3-9af2-85ea3e5403ec',
                    ];

                    return Row(
                      children: imageList.map((url) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 10), // Отступ между изображениями
                          child: InkWell(
                            onTap: () {
                              // Открытие изображения на полный экран
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(
                                      url,
                                      fit: BoxFit
                                          .contain, // Масштабирование изображения
                                    ),
                                  );
                                },
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  8), // Радиус скругления углов
                              child: Image.network(
                                url,
                                width: 70, // Устанавливаем ширину изображения
                                height: 96, // Устанавливаем высоту изображения
                                fit:
                                    BoxFit.cover, // Масштабирование изображения
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 400,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Builder(
                    builder: (context) {
                      // Пример списка данных (каждый элемент содержит свой отзыв)
                      List<Map<String, dynamic>> items = [
                        {
                          'name': 'Иван Иванов',
                          'date': DateTime(2024, 11, 5, 12, 15),
                          'rating': 4,
                          'description': 'Отличный продукт, все понравилось!',
                          'imageList': <String>[],
                        },
                        {
                          'name': 'Мария Петрова',
                          'date': DateTime(2024, 11, 6, 14, 30),
                          'rating': 5,
                          'description': 'Превосходное качество, рекомендую!',
                          'imageList': <String>[],
                        },
                        {
                          'name': 'Алексей Смирнов',
                          'date': DateTime(2024, 11, 7, 10, 0),
                          'rating': 3,
                          'description':
                              'Нормально, но есть некоторые недостатки.',
                          'imageList': <String>[],
                        },
                        {
                          'name': 'Ольга Васильева',
                          'date': DateTime(2024, 11, 8, 18, 45),
                          'rating': 4,
                          'description':
                              'Хорошая покупка, но чуть дороже, чем ожидала.',
                          'imageList': <String>[],
                        },
                      ];

                      return Column(
                        children: items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8), // Расстояние между элементами
                            child: ReviewCard(
                              name: item['name'],
                              date: item['date'],
                              rating: item['rating'],
                              description: item['description'],
                              imageList: item[
                                  'imageList'], // Передаем список изображений
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class StarRatingWidget extends StatefulWidget {
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _rating = 0;

  void _updateRating(int index) {
    setState(() {
      _rating = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => _updateRating(index),
          child: Icon(
            index < _rating ? Icons.star : Icons.star,
            color: index < _rating
                ? Color.fromARGB(255, 244, 160, 15)
                : Color.fromARGB(255, 235, 235, 235),
            size: 28,
          ),
        );
      }),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final DateTime date;
  final int rating;
  final String description;
  final List<String> imageList; // Список URL изображений
  static Color greyDark = Color.fromARGB(255, 48, 48, 48);
  static Color greyMedium = Color.fromARGB(255, 114, 114, 114);
  static Color greyBg = Color.fromARGB(255, 247, 247, 247);
  static Color greyDiv = Color.fromARGB(255, 235, 235, 235);
  static Color greyLight = Color.fromARGB(255, 175, 175, 175);
  static Color main = Color.fromARGB(255, 244, 160, 15);
  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.rating,
    required this.description,
    required this.imageList,
  });

  // Функция для форматирования даты
  String formatDate(DateTime date) {
    final DateFormat formatter =
        DateFormat('d MMMM, HH:mm', 'ru_RU'); // Формат "5 ноября, 12:15"
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: greyDiv, // Цвет границы
          width: 2, // Ширина границы
        ),
        borderRadius: BorderRadius.circular(12), // Радиус скругления углов
      ),
      elevation: 1, // Тень

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            color: greyMedium,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      formatDate(date),
                      style: GoogleFonts.montserrat(
                          color: greyLight,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: List.generate(rating, (index) {
                    return Icon(
                      Icons.star,
                      color: main,
                      size: 24,
                    );
                  }),
                ),
              ],
            ),
            Divider(
              color: greyDiv,
            ),
            // Заглушки изображений
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Прокрутка по горизонтали
              child: Builder(
                builder: (context) {
                  // Пример списка URL изображений
                  List<String> imageList = [
                    'https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%B3%D0%BE%D0%B2%D1%8F%D0%B4%D0%B8%D0%BD%D0%B0%20%D0%BA%D0%B8%D1%81%D0%BB.jpg?alt=media&token=a330644d-3800-487f-83fd-cf22ce09e854',
                    'https://firebasestorage.googleapis.com/v0/b/foodlis-1f062.appspot.com/o/images%2Fdishes%2F%D0%BA%D1%83%D1%80%D0%B8%D1%86%D0%B0.jpg?alt=media&token=0973cc0f-e3ae-4df3-9af2-85ea3e5403ec',
                  ];

                  return Row(
                    children: imageList.map((url) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 10), // Отступ между изображениями
                        child: InkWell(
                          onTap: () {
                            // Открытие изображения на полный экран
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Image.network(
                                    url,
                                    fit: BoxFit
                                        .contain, // Масштабирование изображения
                                  ),
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8), // Радиус скругления углов
                            child: Image.network(
                              url,
                              width: 70, // Устанавливаем ширину изображения
                              height: 96, // Устанавливаем высоту изображения
                              fit: BoxFit.cover, // Масштабирование изображения
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            // Описание
            Text(
              description,
              style: GoogleFonts.montserrat(
                  color: greyLight, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
