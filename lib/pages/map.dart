import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBar: MapAppBar(),
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(0), child: const YandexMap())),
        ]));
  }
}

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

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
            child: Container(
              width: 110,
              child: Center(
                child: Text(
                  "Список",
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 243, 175, 79)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 13,
          ),
          ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 243, 175, 79),
            ),
            child: Container(
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
