import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Поиск',
        hintStyle:
            GoogleFonts.roboto(color: Colors.grey), // Цвет текста подсказки
        prefixIcon: Icon(Icons.search, color: Colors.grey), // Иконка поиска
        filled: true, // Включение фона
        fillColor: Colors.grey[300], // Цвет фона
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
        contentPadding: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 8.0), // Настройка отступов
      ),
    );
  }
}
