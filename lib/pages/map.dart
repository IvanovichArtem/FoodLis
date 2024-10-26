import 'package:flutter/material.dart';
import 'package:food_lis/widgets/map/search_bar_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/map/map_container.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    _fetchRestaurantData();
    restaurantData = widget.data;
  }

  Future<void> _fetchRestaurantData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaraunts').get();

      final List<Map<String, dynamic>> data = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final imageUrl = await _getImageUrl(doc['imageUrl']);
          return {
            'avgPrice': doc['avgPrice'],
            'avgReview': doc['avgReview'],
            'cntReviews': doc['cntReviews'],
            'imageUrl': imageUrl,
            'location': doc['location'],
            'name': doc['name'],
            'restarauntType': doc['restarauntType'],
            'timeByCar': doc['timeByCar'],
            'timeByWalk': doc['timeByWalk'],
            'isToogle': false,
            'documentId': doc.id
          };
        }).toList(),
      );

      setState(() {
        restaurantData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<String> _getImageUrl(String path) async {
    try {
      return await FirebaseStorage.instance.ref(path).getDownloadURL();
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
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
                child: MapContainer(),
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

class ListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const ListScreen({super.key, required this.data});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late List<Map<String, dynamic>> currentData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.data.isEmpty) {
      // Если данные пусты, запускаем загрузку
      _fetchRestaurantData();
    } else {
      currentData = widget.data;
    }
  }

  Future<void> _fetchRestaurantData() async {
    setState(() {
      isLoading = true; // Показываем индикатор загрузки
    });

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaraunts').get();

      final List<Map<String, dynamic>> data = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final imageUrl = await _getImageUrl(doc['imageUrl']);
          return {
            'avgPrice': doc['avgPrice'],
            'avgReview': doc['avgReview'],
            'cntReviews': doc['cntReviews'],
            'imageUrl': imageUrl,
            'location': doc['location'],
            'name': doc['name'],
            'restarauntType': doc['restarauntType'],
            'timeByCar': doc['timeByCar'],
            'timeByWalk': doc['timeByWalk'],
            'isToogle': doc['isToogle'],
            'documentId': doc.id
          };
        }).toList(),
      );

      setState(() {
        currentData = data;
        isLoading = false; // Скрываем индикатор загрузки
      });
    } catch (e) {
      print('Ошибка при загрузке данных: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> _getImageUrl(String path) async {
    try {
      return await FirebaseStorage.instance.ref(path).getDownloadURL();
    } catch (e) {
      print('Ошибка при загрузке URL изображения: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator()) // Показать индикатор загрузки
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 110, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ..._buildItems(), // Генерация виджетов на основе текущих данных
                  ],
                ),
              ),
            ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> items = [];

    for (var item in currentData) {
      items.add(SearchItem(
        imageUrl: item['imageUrl'],
        name: item['name'],
        restarauntType: item['restarauntType'],
        avgReview: item['avgReview'].toDouble(),
        cntReviews: item['cntReviews'],
        timeByWalk: item['timeByWalk'],
        avgPrice: item['avgPrice'],
        isToogle: item['isToogle'],
        documentId: item['documentId'],
      ));
      items.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Divider(color: Color.fromARGB(255, 225, 225, 225)),
      ));
    }

    return items;
  }

  void updateData(List<Map<String, dynamic>> newData) {
    setState(() {
      currentData = newData;
    });
  }
}

class SearchItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String restarauntType;
  final double avgReview;
  final int cntReviews;
  final int timeByWalk;
  final int avgPrice;
  final bool isToogle;
  final String
      documentId; // Добавим идентификатор документа для обновления данных в Firebase

  const SearchItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.restarauntType,
    required this.avgReview,
    required this.cntReviews,
    required this.timeByWalk,
    required this.avgPrice,
    required this.isToogle,
    required this.documentId, // Добавляем новый параметр
  });

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isToogle; // Инициализируем текущее состояние
  }

  // Метод для обновления состояния в Firestore и изменения иконки
  Future<void> _toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    try {
      await FirebaseFirestore.instance
          .collection('restaraunts')
          .doc(widget.documentId) // Используем идентификатор документа
          .update({'isToogle': isBookmarked}); // Обновляем значение в Firestore
    } catch (e) {
      print('Ошибка обновления закладки: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        child: Row(
          children: [
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[200],
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  widget.imageUrl,
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
                        widget.name,
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
                    child: Text(widget.restarauntType,
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
                        widget.avgReview.toString().replaceAll('.', ','),
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
                          getReviewWord(widget.cntReviews),
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
                                "${widget.timeByWalk} мин",
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(
                                        255, 175, 175, 175),
                                    fontSize: 10),
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
                                "${widget.avgPrice} Br",
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
                        GestureDetector(
                          onTap:
                              _toggleBookmark, // Добавляем onTap для переключения
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: isBookmarked
                                ? const Color.fromARGB(255, 243, 145, 8)
                                : const Color.fromARGB(255, 135, 135, 139),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
