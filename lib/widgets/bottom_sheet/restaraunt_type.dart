import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestarauntTypeWidget extends StatefulWidget {
  final List<Map<String, dynamic>> buttonsData; // Данные кнопок

  const RestarauntTypeWidget({
    super.key,
    required this.buttonsData,
  });

  @override
  State<RestarauntTypeWidget> createState() => _RestarauntTypeWidgetState();
}

class _RestarauntTypeWidgetState extends State<RestarauntTypeWidget> {
  late List<Map<String, dynamic>> buttons;

  @override
  void initState() {
    super.initState();
    buttons = widget.buttonsData; // Инициализация кнопок данными из параметров
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Тип заведения",
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 92, 92, 92),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4), // Отступ между заголовком и кнопками
          Wrap(
            spacing: 6,
            runSpacing: 8, // Расстояние между строками
            alignment: WrapAlignment.spaceBetween, // Выравнивание по ширине
            children: buttons.map((button) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    button['isSelected'] =
                        !button['isSelected']; // Переключаем состояние кнопки
                  });
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: (() {
                      final textSpan = TextSpan(
                        text: button['name'],
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: button['isSelected']
                              ? Colors.white
                              : const Color.fromARGB(255, 191, 191, 191),
                        ),
                      );

                      final textPainter = TextPainter(
                        text: textSpan,
                        textDirection: TextDirection.ltr,
                      );

                      textPainter.layout();
                      return textPainter.width +
                          23; // Ширина текста + 23 пикселя
                    })(),
                  ),
                  height: 30, // Увеличен размер для лучшего отображения
                  decoration: BoxDecoration(
                    color: button['isSelected']
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !button['isSelected']
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // Закругленные края
                  ),
                  alignment: Alignment.center,
                  child: IntrinsicWidth(
                    child: Text(
                      button['name'],
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: button['isSelected']
                            ? Colors.white
                            : const Color.fromARGB(255, 191, 191, 191),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
