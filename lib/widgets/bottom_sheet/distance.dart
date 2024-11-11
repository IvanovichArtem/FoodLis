import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DistanceWidget extends StatefulWidget {
  const DistanceWidget({super.key});

  @override
  State<DistanceWidget> createState() => DistanceWidgetState();
}

class DistanceWidgetState extends State<DistanceWidget> {
  double _value = 4.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 3, vertical: 5), // Добавлено для отступов
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Выравнивание по левому краю
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Расстояние от меня",
              style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Row(
              children: [
                Text(
                  "Мое местоположение",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 114, 114, 114),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 8,
                ),
                FaIcon(
                  FontAwesomeIcons.mapLocationDot,
                  color: const Color.fromARGB(255, 114, 114, 114),
                  size: 16,
                )
              ],
            ),
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
                activeLabelStyle: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 191, 191, 191)),
                inactiveLabelStyle: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 191, 191, 191))),
            child: SizedBox(
              width: 370,
              child: SfSlider(
                min: 0,
                max: 40,
                value: _value,
                interval: 20,
                stepSize: 5,
                activeColor: const Color.fromARGB(255, 243, 175, 79),
                showLabels: true,
                showTicks: false,
                showDividers: false,
                thumbShape: _SfThumbShape(),
                labelFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  return '$formattedText км';
                },
                minorTicksPerInterval: 1,
                onChanged: (dynamic newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reset() {
    setState(() {
      _value = 4.0;
    });
  }

  getCurrentState() {
    return _value;
  }
}

class _SfThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    // Рисуем жёлтый обвод
    final Paint outlinePaint = Paint()
      ..color = const Color.fromARGB(255, 243, 175, 79) // Цвет обводки
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Рисуем белый круг
    final Paint fillPaint = Paint()
      ..color = Colors.white // Цвет круга
      ..style = PaintingStyle.fill;

    // Рисуем круг с радиусом 15
    context.canvas.drawCircle(center, 10, outlinePaint); // Обводка
    context.canvas.drawCircle(center, 9, fillPaint); // Заполнение
  }
}
