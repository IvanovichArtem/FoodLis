import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KitchensFilterWidget extends StatefulWidget {
  final List<Map<String, dynamic>> kitchenData;
  final int itemInRow;

  const KitchensFilterWidget(
      {super.key, required this.kitchenData, required this.itemInRow});

  @override
  State<KitchensFilterWidget> createState() => KitchensFilterWidgetState();
}

class KitchensFilterWidgetState extends State<KitchensFilterWidget> {
  late List<KitchenItemState> kitchenItems;

  @override
  void initState() {
    super.initState();
    kitchenItems = widget.kitchenData.map((data) {
      return KitchenItemState(
        name: data['name'],
        imageUrl: data['imageUrl'],
        isSelected: false,
      );
    }).toList();
  }

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
              color: const Color.fromARGB(255, 48, 48, 48),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          GridView.count(
            crossAxisCount: widget.itemInRow,
            shrinkWrap: true,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(widget.kitchenData.length, (index) {
              return KitchenItem(
                isSelected: kitchenItems[index].isSelected,
                name: kitchenItems[index].name,
                imageUrl: kitchenItems[index].imageUrl,
                width: widget.kitchenData[index]['width'],
                height: widget.kitchenData[index]['height'],
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

class KitchenItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;
  final double width;
  final double height;
  final ValueChanged<bool> onSelected;

  const KitchenItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    required this.width,
    required this.height,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!isSelected);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? const Color.fromARGB(255, 243, 175, 79)
                    : Colors.transparent,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: width,
                height: height,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 48, 48, 48),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KitchensFilterWidget2 extends StatefulWidget {
  final List<Map<String, dynamic>> kitchenData;
  final int itemInRow;

  const KitchensFilterWidget2(
      {super.key, required this.kitchenData, required this.itemInRow});

  @override
  State<KitchensFilterWidget2> createState() => KitchensFilterWidget2State();
}

class KitchensFilterWidget2State extends State<KitchensFilterWidget2> {
  late List<KitchenItemState> kitchenItems;

  @override
  void initState() {
    super.initState();
    kitchenItems = widget.kitchenData.map((data) {
      return KitchenItemState(
        name: data['name'],
        imageUrl: data['imageUrl'],
        isSelected: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Время дня",
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 48, 48, 48),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          GridView.count(
            crossAxisCount: widget.itemInRow,
            shrinkWrap: true,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(widget.kitchenData.length, (index) {
              return KitchenItem(
                isSelected: kitchenItems[index].isSelected,
                name: kitchenItems[index].name,
                imageUrl: kitchenItems[index].imageUrl,
                width: widget.kitchenData[index]['width'],
                height: widget.kitchenData[index]['height'],
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
}
