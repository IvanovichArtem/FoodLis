import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchMapBar extends StatefulWidget {
  const SearchMapBar({super.key});

  @override
  State<SearchMapBar> createState() => _SearchMapBarState();
}

class _SearchMapBarState extends State<SearchMapBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Поиск',
          hintStyle: GoogleFonts.montserrat(
              color: const Color.fromARGB(
                  255, 138, 138, 142)), // Цвет текста подсказки
          prefixIcon: const Icon(Icons.search,
              color: Color.fromARGB(255, 138, 138, 142)), // Иконка поиска
          filled: true, // Включение фона
          fillColor: const Color.fromARGB(255, 235, 235, 235), // Цвет фона
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Скругление углов
            borderSide: BorderSide.none, // Убираем обводку
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Убираем обводку в обычном состоянии
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Убираем обводку при фокусе
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5.0, horizontal: 8.0), // Настройка отступов
        ),
      ), // Ваш виджет поисковой строки
    );
  }
}
