import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final ValueNotifier<bool> isSelectedNotifier;

  const CustomToggleSwitch({super.key, required this.isSelectedNotifier});

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isSelectedNotifier,
      builder: (context, isSelected, child) {
        return GestureDetector(
          onTap: () {
            widget.isSelectedNotifier.value =
                !isSelected; // Переключаем значение
          },
          child: Container(
            width: 50,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSelected
                  ? const Color.fromARGB(255, 243, 175, 79)
                  : Colors.grey[300],
            ),
            alignment:
                isSelected ? Alignment.centerRight : Alignment.centerLeft,
            padding: const EdgeInsets.all(3), // Отступ для "кнопки"
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
