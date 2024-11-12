import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultipleToogleWidget extends StatefulWidget {
  final List<Map<String, dynamic>> buttonsData;
  final String text; // Данные кнопок

  const MultipleToogleWidget({
    super.key,
    required this.buttonsData,
    required this.text,
  });

  @override
  State<MultipleToogleWidget> createState() => MultipleToogleWidgetState();
}

class MultipleToogleWidgetState extends State<MultipleToogleWidget> {
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
            widget.text,
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 48, 48, 48),
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
                        : Color.fromARGB(255, 247, 247, 247),
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

  // Метод для сброса состояния
  void reset() {
    setState(() {
      buttons = widget.buttonsData;
    });
  }

  // Метод для получения текущего состояния кнопок
  Map<String, bool> getCurrentState() {
    Map<String, bool> currentState = {};
    for (var button in buttons) {
      currentState[button['name']] = button['isSelected'];
    }
    return currentState;
  }
}

class MultipleToogleWidgetRating extends StatefulWidget {
  final List<Map<String, dynamic>> buttonsData;
  final String text; // Данные кнопок

  const MultipleToogleWidgetRating({
    super.key,
    required this.buttonsData,
    required this.text,
  });

  @override
  State<MultipleToogleWidgetRating> createState() =>
      MultipleToogleWidgetRatingState();
}

class MultipleToogleWidgetRatingState
    extends State<MultipleToogleWidgetRating> {
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
            widget.text,
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 48, 48, 48),
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
                        : Color.fromARGB(255, 247, 247, 247),
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

  // Метод для сброса состояния
  void reset() {
    setState(() {
      buttons = widget.buttonsData;
    });
  }

  // Метод для получения текущего состояния кнопок
  Map<String, bool> getCurrentState() {
    Map<String, bool> currentState = {};
    for (var button in buttons) {
      currentState[button['name']] = button['isSelected'];
    }
    return currentState;
  }
}

class MultipleToogleWidgetRestrictions extends StatefulWidget {
  final List<Map<String, dynamic>> buttonsData;
  final String text; // Данные кнопок

  const MultipleToogleWidgetRestrictions({
    super.key,
    required this.buttonsData,
    required this.text,
  });

  @override
  MultipleToogleWidgetRestrictionsState createState() =>
      MultipleToogleWidgetRestrictionsState();
}

class MultipleToogleWidgetRestrictionsState
    extends State<MultipleToogleWidgetRestrictions> {
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
            widget.text,
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 48, 48, 48),
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
                        : Color.fromARGB(255, 247, 247, 247),
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

  // Метод для сброса состояния
  void reset() {
    setState(() {
      buttons = widget.buttonsData;
    });
  }

  // Метод для получения текущего состояния кнопок
  Map<String, bool> getCurrentState() {
    Map<String, bool> currentState = {};
    for (var button in buttons) {
      currentState[button['name']] = button['isSelected'];
    }
    return currentState;
  }
}

class MultipleToogleWidgetWithIcons extends StatefulWidget {
  final List<Map<String, dynamic>> buttonsData;
  final String text; // Данные кнопок

  const MultipleToogleWidgetWithIcons({
    super.key,
    required this.buttonsData,
    required this.text,
  });

  @override
  State<MultipleToogleWidgetWithIcons> createState() =>
      MultipleToogleWidgetWithIconsState();
}

class MultipleToogleWidgetWithIconsState
    extends State<MultipleToogleWidgetWithIcons> {
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
            widget.text,
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 48, 48, 48),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4), // Отступ между заголовком и кнопками
          Wrap(
            spacing: 3,
            runSpacing: 8, // Расстояние между строками
            // alignment: WrapAlignment., // Выравнивание по ширине
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
                      return textPainter.width + 40;
                    })(),
                  ),
                  height: 30, // Увеличен размер для лучшего отображения
                  decoration: BoxDecoration(
                    color: button['isSelected']
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Color.fromARGB(255, 247, 247, 247),
                    borderRadius:
                        BorderRadius.circular(10), // Закругленные края
                  ),
                  alignment: Alignment.center,
                  child: IntrinsicWidth(
                    child: Row(
                      children: [
                        Text(
                          button['name'],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: button['isSelected']
                                ? Colors.white
                                : const Color.fromARGB(255, 191, 191, 191),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(button['icon'],
                            size: 16,
                            color: button['isSelected']
                                ? Colors.white
                                : const Color.fromARGB(255, 191, 191, 191)),
                      ],
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

  // Метод для сброса состояния
  void reset() {
    setState(() {
      buttons = widget.buttonsData;
    });
  }

  // Метод для получения текущего состояния кнопок
  Map<String, bool> getCurrentState() {
    Map<String, bool> currentState = {};
    for (var button in buttons) {
      currentState[button['name']] = button['isSelected'];
    }
    return currentState;
  }
}
