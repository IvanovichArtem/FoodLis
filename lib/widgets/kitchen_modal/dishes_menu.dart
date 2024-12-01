import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dish_card.dart';

class DishesMenu extends StatefulWidget {
  final List menuItems;
  const DishesMenu({super.key, required this.menuItems});

  @override
  State<DishesMenu> createState() => _DishesMenuState();
}

class _DishesMenuState extends State<DishesMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Меню",
          style: GoogleFonts.montserrat(
              color: Color.fromARGB(255, 48, 48, 48),
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Builder(
          builder: (context) {
            return Wrap(
              spacing: 16.0, // Отступы между элементами по горизонтали
              runSpacing: 16.0, // Отступы между строками
              children: List.generate(widget.menuItems.length, (index) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) /
                      2, // Ширина для двух элементов в строке (с учётом отступов)
                  child: DishCard(
                    name: widget.menuItems[index]['name'],
                    top: -1,
                    imageUrl: widget.menuItems[index]['imageUrl'],
                    cost: widget.menuItems[index]['cost'].toDouble(),
                    weight: widget.menuItems[index]['weight'],
                    rating: widget.menuItems[index]['rating'],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
