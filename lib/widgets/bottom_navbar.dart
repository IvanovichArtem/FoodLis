import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.grid_view),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.location_on_outlined),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.tag_faces_sharp),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: '',
    ),
  ];

  final Color _selectedColor =
      const Color(0xFFF3AF4F); // Цвет для выбранного элемента
  final Color _unselectedColor = Colors.grey; // Цвет для невыбранных элементов

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: _items.map((item) {
          int index = _items.indexOf(item);
          bool isSelected = index == widget.selectedIndex;
          return BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: isSelected
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedColor.withOpacity(1),
                    )
                  : null,
              padding: const EdgeInsets.all(8),
              child: IconTheme(
                data: IconThemeData(
                  color: isSelected ? Colors.white : _unselectedColor,
                  size: 30,
                ),
                child: item.icon,
              ),
            ),
            label: '',
          );
        }).toList(),
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: _selectedColor),
        unselectedItemColor: _unselectedColor,
        onTap: widget.onItemTapped,
      ),
    );
  }
}
