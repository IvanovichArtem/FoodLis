import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class KitchensFilterWidget extends StatefulWidget {
  const KitchensFilterWidget({super.key});

  @override
  State<KitchensFilterWidget> createState() => KitchensFilterWidgetState();
}

class KitchensFilterWidgetState extends State<KitchensFilterWidget> {
  // Структура для хранения состояния каждого KitchenItem
  List<KitchenItemState> kitchenItems = List.generate(
    6,
    (index) => KitchenItemState(
      name: _getKitchenName(index),
      imageUrl: _getKitchenImageUrl(index),
      isSelected: false,
    ),
  );

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
          const SizedBox(height: 5),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(6, (index) {
              return KitchenItem(
                isSelected: kitchenItems[index].isSelected,
                name: kitchenItems[index].name,
                imageUrl: kitchenItems[index].imageUrl,
                onSelected: (isSelected) {
                  setState(() {
                    kitchenItems[index].isSelected = isSelected;
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Метод для получения текущего состояния выбранных категорий
  List<String> getCurrentState() {
    return kitchenItems
        .where((item) => item.isSelected)
        .map((item) => item.name)
        .toList();
  }

  void reset() {
    setState(() {
      for (var item in kitchenItems) {
        item.isSelected = false;
      }
    });
  }

  // Методы для получения имени и URL для кухни
  static String _getKitchenName(int index) {
    switch (index) {
      case 0:
        return 'Азиатская';
      case 1:
        return 'Итальянская';
      case 2:
        return 'Грузинская';
      case 3:
        return 'Мексиканская';
      case 4:
        return 'Белорусская';
      case 5:
        return 'Вегетарианская';
      default:
        return '';
    }
  }

  static String _getKitchenImageUrl(int index) {
    switch (index) {
      case 0:
        return 'images/kitchens/азиатская.jpg';
      case 1:
        return 'images/kitchens/итальянская кухня_2.jpg';
      case 2:
        return 'images/kitchens/грузинская.jpg';
      case 3:
        return 'images/kitchens/мексиканская.jpg';
      case 4:
        return 'images/kitchens/белорусская.jpg';
      case 5:
        return 'images/kitchens/вегетарианская.jpg';
      default:
        return '';
    }
  }
}

// Модель для хранения состояния каждого элемента
class KitchenItemState {
  String name;
  String imageUrl;
  bool isSelected;

  KitchenItemState({
    required this.name,
    required this.imageUrl,
    required this.isSelected,
  });
}

class KitchenItem extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const KitchenItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    required this.onSelected,
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
      onTap: () {
        widget.onSelected(!widget.isSelected);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isSelected
                    ? const Color.fromARGB(255, 243, 175, 79)
                    : Colors.transparent,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _imageUrl != null
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
            ),
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
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
