import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KitchensFilterWidget extends StatefulWidget {
  const KitchensFilterWidget({super.key});

  @override
  State<KitchensFilterWidget> createState() => _KitchensFilterWidgetState();
}

class _KitchensFilterWidgetState extends State<KitchensFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Кухня",
            style: GoogleFonts.roboto(
              color: const Color.fromARGB(255, 92, 92, 92),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
              height:
                  5), // Задайте нужный отступ между заголовком и первой строкой
          GridView.count(
            crossAxisCount: 3, // Количество столбцов
            shrinkWrap: true, // Уменьшение высоты
            crossAxisSpacing: 16, // Расстояние между столбцами
            mainAxisSpacing: 0, // Расстояние между строками
            physics:
                const NeverScrollableScrollPhysics(), // Отключение прокрутки
            children: const [
              KitchenItem(
                name: 'Азиатская',
                imageUrl1: 'assets/images/kitchens/азиатская.jpg',
                imageUrl2: 'assets/images/kitchens/азиатская_анимация.jpg',
              ),
              KitchenItem(
                name: 'Итальянская',
                imageUrl1: 'assets/images/kitchens/итальянская кухня_2.jpg',
                imageUrl2: 'assets/images/kitchens/итальянская кухня_2.jpg',
              ),
              KitchenItem(
                name: 'Грузинская',
                imageUrl1: 'assets/images/kitchens/грузинская.jpg',
                imageUrl2: 'assets/images/kitchens/грузинская.jpg',
              ),
              KitchenItem(
                name: 'Мексиканская',
                imageUrl1: 'assets/images/kitchens/мексиканская.jpg',
                imageUrl2: 'assets/images/kitchens/мексиканская.jpg',
              ),
              KitchenItem(
                name: 'Белорусская',
                imageUrl1: 'assets/images/kitchens/белорусская.jpg',
                imageUrl2: 'assets/images/kitchens/белорусская.jpg',
              ),
              KitchenItem(
                name: 'Вегетарианская',
                imageUrl1: 'assets/images/kitchens/вегетарианская.jpg',
                imageUrl2: 'assets/images/kitchens/вегетарианская.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KitchenItem extends StatefulWidget {
  final String name;
  final String imageUrl1; // Первый путь к изображению
  final String imageUrl2; // Второй путь к изображению
  // TODO: Начать делать анимацию

  const KitchenItem({
    super.key,
    required this.name,
    required this.imageUrl1,
    required this.imageUrl2,
  });

  @override
  _KitchenItemState createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  bool _showFirstImage = true;

  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleImage, // Переключение изображения при нажатии
      child: SizedBox(
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                _showFirstImage ? widget.imageUrl1 : widget.imageUrl2,
                key: ValueKey(_showFirstImage), // Уникальный ключ для анимации
                width: 100,
                height: 84,
              ),
            ),
            Text(
              widget.name,
              style: GoogleFonts.roboto(
                color: const Color.fromARGB(255, 92, 92, 92),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
