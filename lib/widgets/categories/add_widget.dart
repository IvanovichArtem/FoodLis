import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalScrollAddWidget extends StatefulWidget {
  @override
  _HorizontalScrollAddWidgetState createState() =>
      _HorizontalScrollAddWidgetState();
}

class _HorizontalScrollAddWidgetState extends State<HorizontalScrollAddWidget> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120, // Высота для карточек
          child: PageView(
            controller: _pageController,
            children: [
              _buildCard(
                  'assets/images/рекламная карточка.jpg',
                  'Обеденное меню\nв ресторане MIMO\nот 5 рублей',
                  'Первомайская 5'),
              _buildCard('assets/images/рекламная карточка 2.jpg',
                  'Получи вишневый\nпирог в кофейне\nУми', 'Ленина 23'),
              // Добавьте дополнительные карточки при необходимости
            ],
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _pageController,
          count: 2, // Укажите количество карточек
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.orange,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String imageUrl, String title, String address) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl), // Путь к вашему изображению
            fit: BoxFit.cover, // Покрытие всего контейнера изображением
          ),
          borderRadius: BorderRadius.circular(16.0), // Скругление углов
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 12, 0, 15),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 13, 0),
              child: Text(
                address,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
