import 'package:flutter/material.dart';
import 'package:food_lis/widgets/map/search_bar_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/map/map_container.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MapAppBar(),
        body: Column(children: <Widget>[
          const Expanded(
            child: MapContainer(),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Поисковая
                          const SearchMapBar(),
                          // Фильтр
                          GestureDetector(
                            onTap: () {
                              showCustomBottomSheet(
                                  context); // Вызываем функцию из другого файла
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
                                backgroundColor:
                                    const Color.fromARGB(255, 243, 175, 79),
                                minimumSize: const Size(
                                    0, 30), // убираем минимальную ширину
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8), // немного уменьшаем отступы
                              ),
                              child: Text(
                                "Все",
                                style: GoogleFonts.roboto(
                                  fontSize: 13, // уменьшаем шрифт
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
                                  color: Color.fromARGB(255, 193, 193, 193),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: Text(
                                "Избранное",
                                style: GoogleFonts.roboto(
                                  fontSize: 11, // уменьшаем шрифт
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 193, 193, 193),
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
                                  color: Color.fromARGB(255, 193, 193, 193),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: Text(
                                "Челленджи",
                                style: GoogleFonts.roboto(
                                  fontSize: 11, // уменьшаем шрифт
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 193, 193, 193),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppBar({super.key});

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
        mainAxisSize: MainAxisSize.min, // Чтобы кнопки были по центру
        children: [
          ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Цвет кнопки
            ),
            child: SizedBox(
              width: 110,
              child: Center(
                child: Text(
                  "Список",
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 243, 175, 79)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 243, 175, 79),
            ),
            child: SizedBox(
                width: 110,
                child: Center(
                    child: Text(
                  "Карта",
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }
}
