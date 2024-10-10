import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            style: GoogleFonts.montserrat(
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
            crossAxisSpacing: 12, // Расстояние между столбцами
            mainAxisSpacing: 0, // Расстояние между строками
            physics:
                const NeverScrollableScrollPhysics(), // Отключение прокрутки
            children: const [
              KitchenItem(
                name: 'Азиатская',
                imageUrl: 'images/kitchens/азиатская.jpg',
              ),
              KitchenItem(
                name: 'Итальянская',
                imageUrl: 'images/kitchens/итальянская кухня_2.jpg',
              ),
              KitchenItem(
                name: 'Грузинская',
                imageUrl: 'images/kitchens/грузинская.jpg',
              ),
              KitchenItem(
                name: 'Мексиканская',
                imageUrl: 'images/kitchens/мексиканская.jpg',
              ),
              KitchenItem(
                name: 'Белорусская',
                imageUrl: 'images/kitchens/белорусская.jpg',
              ),
              KitchenItem(
                name: 'Вегетарианская',
                imageUrl: 'images/kitchens/вегетарианская.jpg',
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
  final String imageUrl; // Путь к изображению в Firebase Storage

  const KitchenItem({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  _KitchenItemState createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // Получаем ссылку на изображение из Firebase Storage
    try {
      String downloadUrl =
          await FirebaseStorage.instance.ref(widget.imageUrl).getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Ошибка загрузки изображения: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // Вы можете добавить свою логику по нажатию
      child: SizedBox(
        child: Column(
          children: [
            _imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: _imageUrl!,
                    width: 120,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  ),
            SizedBox(
              width: 110,
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
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
