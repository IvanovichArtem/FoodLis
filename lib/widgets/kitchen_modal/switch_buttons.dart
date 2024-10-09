import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchButtons extends StatefulWidget {
  const SwitchButtons({super.key});

  @override
  _SwitchButtonsState createState() => _SwitchButtonsState();
}

class _SwitchButtonsState extends State<SwitchButtons> {
  bool isOutsideSelected = true; // По умолчанию выбрана кнопка "Снаружи"

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Кнопка "Снаружи"
          AnimatedContainer(
            height: 28,
            width: 172,
            duration: const Duration(milliseconds: 300), // Время анимации
            curve: Curves.ease, // Кривая анимации
            decoration: BoxDecoration(
              color: isOutsideSelected ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: !isOutsideSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]
                  : [],
            ),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  isOutsideSelected = true; // Активируем "Снаружи"
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isOutsideSelected ? Colors.orange : Colors.transparent,
                ),
              ),
              child: Text(
                "Снаружи",
                style: GoogleFonts.montserrat(
                  color: isOutsideSelected ? Colors.white : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Кнопка "Внутри"
          AnimatedContainer(
            height: 28,
            width: 172,
            duration: const Duration(milliseconds: 300), // Время анимации
            curve: Curves.ease, // Кривая анимации
            decoration: BoxDecoration(
              color: !isOutsideSelected ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isOutsideSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]
                  : [],
            ),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  isOutsideSelected = false; // Активируем "Внутри"
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color:
                      !isOutsideSelected ? Colors.orange : Colors.transparent,
                ),
              ),
              child: Text(
                "Внутри",
                style: GoogleFonts.montserrat(
                  color: !isOutsideSelected ? Colors.white : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
