import 'package:flutter/material.dart';
import 'package:food_lis/widgets/map/search_bar_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/map/map_container.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> data;

  const MapScreen({super.key, required this.initialIndex, required this.data});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> restaurantData = [];
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    restaurantData = widget.data;
  }

  void _onButtonPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MapAppBar(
        onButtonPressed: _onButtonPressed,
        currentIndex: _currentIndex,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ListScreen(data: restaurantData),
          Stack(
            children: <Widget>[
              // YandexMap должен находиться под всеми элементами
              const Positioned.fill(
                child: MapContainer(), // YandexMap внутри MapContainer
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 243, 243),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SearchMapBar(),
                                GestureDetector(
                                  onTap: () {
                                    showCustomBottomSheet(context);
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 243, 175, 79),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.sliders,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 105,
                                  child: ElevatedButton(
                                    onPressed: () => {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 243, 175, 79),
                                      minimumSize: const Size(0, 30),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    child: Text(
                                      "Все",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 105,
                                  child: ElevatedButton(
                                    onPressed: () => {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      minimumSize: const Size(0, 30),
                                      side: const BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    child: Text(
                                      "Избранное",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 193, 193, 193),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 105,
                                  child: ElevatedButton(
                                    onPressed: () => {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      minimumSize: const Size(0, 30),
                                      side: const BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 193, 193, 193),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    child: Text(
                                      "Челленджи",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 193, 193, 193),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onButtonPressed;
  final int currentIndex;

  const MapAppBar({
    super.key,
    required this.onButtonPressed,
    required this.currentIndex,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => onButtonPressed(0),
            style: ElevatedButton.styleFrom(
              backgroundColor: currentIndex == 0
                  ? const Color.fromARGB(255, 243, 175, 79)
                  : Colors.white,
            ),
            child: SizedBox(
              width: 110,
              child: Center(
                child: Text(
                  "Список",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: currentIndex == 0
                          ? Colors.white
                          : const Color.fromARGB(255, 243, 175, 79)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 13),
          ElevatedButton(
            onPressed: () => onButtonPressed(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: currentIndex == 1
                  ? const Color.fromARGB(255, 243, 175, 79)
                  : Colors.white,
            ),
            child: SizedBox(
              width: 110,
              child: Center(
                child: Text(
                  "Карта",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: currentIndex == 1
                          ? Colors.white
                          : const Color.fromARGB(255, 243, 175, 79)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data; // Добавляем список данных

  const ListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 110, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Элементы будут выравниваться вверху
            children: [
              ..._buildItems(), // Генерируем виджеты на основе данных
            ],
          ),
        ),
      ),
    );
  }

  // Метод для генерации списка виджетов
  List<Widget> _buildItems() {
    List<Widget> items = [];

    for (var item in data) {
      items.add(SearchItem(
        imageUrl: item['imageUrl'],
        name: item['name'],
        restType: item['restType'],
        meanScore: item['meanScore'],
        reviewsCount: item['reviewsCount'],
        minutesToRest: item['minutesToRest'],
        meanCost: item['meanCost'],
        isToogle: item['isToogle'],
      ));
      items.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Divider(color: Color.fromARGB(255, 225, 225, 225)),
      ));
    }

    return items;
  }
}

class SearchItem extends StatelessWidget {
  String getReviewWord(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return "$count отзыв";
    } else if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return "$count отзыва";
    } else {
      return "$count отзывов";
    }
  }

  final String imageUrl;
  final String name;
  final String restType;
  final double meanScore;
  final int reviewsCount;
  final int minutesToRest;
  final int meanCost;
  final bool isToogle;
  const SearchItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.restType,
      required this.meanScore,
      required this.reviewsCount,
      required this.minutesToRest,
      required this.meanCost,
      required this.isToogle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        child: Row(
          children: [
            Container(
              height: 140, // Задайте высоту контейнера
              width: 120, // Задайте ширину контейнера
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors
                    .grey[200], // Цвет фона, если изображение не загрузилось
              ),
              clipBehavior: Clip
                  .hardEdge, // Убедитесь, что содержимое обрезается по радиусам
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(10)), // Задайте радиус
                child: Image.asset(
                  imageUrl, // Ваш путь к изображению
                  fit: BoxFit.cover,
                  height: 140,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                    child: SizedBox(
                      width: 190,
                      height: 25,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 114, 114, 114),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 190,
                    child: Text(restType,
                        style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 114, 114, 114),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        color: Color.fromARGB(255, 229, 145, 18),
                        size: 14,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        meanScore.toString().replaceAll('.', ','),
                        style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 114, 114, 114),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Icon(Icons.circle,
                            size: 4, color: Color.fromARGB(255, 114, 114, 114)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          getReviewWord(reviewsCount),
                          style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 114, 114, 114),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 234, 234, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.airport_shuttle_outlined,
                                color: Color.fromARGB(255, 175, 175, 175),
                                size: 18,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "$minutesToRest мин",
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(
                                        255, 175, 175, 175),
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 234, 234, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$meanCost Br",
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(
                                        255, 175, 175, 175),
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 38,
                        ),
                        Icon(
                            isToogle
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: isToogle
                                ? const Color.fromARGB(255, 243, 145, 8)
                                : const Color.fromARGB(255, 135, 135, 139))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
