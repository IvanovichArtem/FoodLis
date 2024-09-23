import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestarauntTypeWidget extends StatefulWidget {
  const RestarauntTypeWidget({super.key});

  @override
  State<RestarauntTypeWidget> createState() => _RestarauntTypeWidgetState();
}

class _RestarauntTypeWidgetState extends State<RestarauntTypeWidget> {
  List<Map<String, dynamic>> buttons = [
    {'name': 'Ресторан', 'isSelected': false},
    {'name': 'Кафе', 'isSelected': false},
    {'name': 'Бар', 'isSelected': false},
    {'name': 'Караоке', 'isSelected': false},
    {'name': 'Чайная', 'isSelected': false},
    {'name': 'Пекарня', 'isSelected': false},
    {'name': 'Кальян', 'isSelected': false},
    {'name': 'Бабл ти', 'isSelected': false},
  ];
  //TODO: Подумать как красиво сделать
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Тип заведения",
            style: GoogleFonts.roboto(
              color: const Color.fromARGB(255, 92, 92, 92),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4), // Отступ между заголовком и кнопками
          Wrap(
            spacing: 6,
            runSpacing: 10, // Расстояние между строками
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
                        style: GoogleFonts.roboto(
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
                          30; // Ширина текста + 30 пикселей
                    })(),
                  ),
                  height: 23,
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
                      style: GoogleFonts.roboto(
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
