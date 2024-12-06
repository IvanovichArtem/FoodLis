import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchButtons extends StatefulWidget {
  const SwitchButtons({Key? key}) : super(key: key);

  @override
  _SwitchButtonsState createState() => _SwitchButtonsState();
}

class _SwitchButtonsState extends State<SwitchButtons> {
  bool isOutsideSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromARGB(255, 244, 160, 15)),
      ),
      child: Stack(
        children: [
          // Слой с фоновым эффектом
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: isOutsideSelected ? 0 : 165, // изменение положения фона
            right: isOutsideSelected ? 165 : 0,
            top: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 160, 15),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Кнопка "Снаружи"
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOutsideSelected = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10)),
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      style: GoogleFonts.montserrat(
                        color: isOutsideSelected
                            ? Colors.white
                            : Color.fromARGB(255, 244, 160, 15),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Text("Снаружи"),
                    ),
                  ),
                ),
              ),
              // Кнопка "Внутри"
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOutsideSelected = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      style: GoogleFonts.montserrat(
                        color: !isOutsideSelected
                            ? Colors.white
                            : Color.fromARGB(255, 244, 160, 15),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Text("Внутри"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
