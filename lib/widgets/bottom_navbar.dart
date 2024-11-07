import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final Color _selectedColor = const Color(0xFFF3AF4F);
  final Color _unselectedColor = Colors.grey;

  Widget _buildSvgIcon(String assetName, bool isSelected) {
    return SvgPicture.asset(
      assetName,
      color: isSelected ? Colors.white : _unselectedColor,
      width: 24, // Уменьшенный размер иконок
      height: 24,
    );
  }

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
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 50, // Уменьшенный размер контейнера
              height: 50,
              padding:
                  const EdgeInsets.all(8), // Отступ для иконки внутри круга
              decoration: widget.selectedIndex == 0
                  ? BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: _buildSvgIcon(
                  'assets/svg/grid.svg', widget.selectedIndex == 0),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: widget.selectedIndex == 1
                  ? BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: _buildSvgIcon('assets/svg/bottom_navbar_pin.svg',
                  widget.selectedIndex == 1),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: widget.selectedIndex == 2
                  ? BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: _buildSvgIcon(
                  'assets/svg/challenge.svg', widget.selectedIndex == 2),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: widget.selectedIndex == 3
                  ? BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: _buildSvgIcon(
                  'assets/svg/account_circle.svg', widget.selectedIndex == 3),
            ),
            label: '',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: _unselectedColor,
        onTap: widget.onItemTapped,
      ),
    );
  }
}
