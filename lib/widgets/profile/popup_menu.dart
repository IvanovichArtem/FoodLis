import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconPopupMenu extends StatefulWidget {
  final List<String> menuItems; // Добавим параметр для текстов меню

  const IconPopupMenu({super.key, required this.menuItems});

  @override
  _IconPopupMenuState createState() => _IconPopupMenuState();
}

class _IconPopupMenuState extends State<IconPopupMenu> {
  Color iconColor = const Color.fromARGB(255, 193, 193, 193);
  Color backgroundColor = Colors.transparent;

  void changeIconAppearance(bool isOpen) {
    setState(() {
      if (isOpen) {
        iconColor = Colors.white;
        backgroundColor = const Color.fromARGB(255, 243, 175, 79);
      } else {
        iconColor = const Color.fromARGB(255, 193, 193, 193);
        backgroundColor = Colors.transparent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          color: Colors.white,
          icon: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Icon(
              Icons.more_vert,
              color: iconColor,
              size: 18,
            ),
          ),
          onOpened: () => changeIconAppearance(true),
          onCanceled: () => changeIconAppearance(false),
          onSelected: (String value) {
            changeIconAppearance(false);
          },
          itemBuilder: (BuildContext context) {
            return widget.menuItems.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 138, 138, 142)),
                ),
              );
            }).toList();
          },
          offset: const Offset(-7, 47),
        ),
      ],
    );
  }
}
