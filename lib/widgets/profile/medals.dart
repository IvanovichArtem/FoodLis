import 'package:flutter/material.dart';

class Medals extends StatelessWidget {
  const Medals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(0, 10, 50, 0), // Отступы внутри контейнера
      child: SizedBox(
        width: 100, // Установите фиксированную ширину для Stack
        height: 30, // Установите фиксированную высоту для Stack
        child: Stack(
          children: [
            // Первый кружок
            _buildCircle(color: const Color(0xFFA8B400), left: 0), // Зелёный
            // Второй кружок
            _buildCircle(color: const Color(0xFFFF8C00), left: 10), // Оранжевый
            // Третий кружок
            _buildCircle(color: const Color(0xFF76C4C8), left: 20), // Голубой
            // Четвертый кружок
            _buildCircle(color: const Color(0xFFFFD600), left: 30), // Желтый
          ],
        ),
      ),
    );
  }

  // Метод для создания кружка
  Widget _buildCircle({required Color color, required double left}) {
    return Positioned(
      left: left,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color, // Цвет кружка
          border: Border.all(color: Colors.white, width: 2), // Белая обводка
        ),
      ),
    );
  }
}
