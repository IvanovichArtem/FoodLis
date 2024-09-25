import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DistanceWidget extends StatefulWidget {
  const DistanceWidget({super.key});

  @override
  State<DistanceWidget> createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> {
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
              style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
                activeLabelStyle: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 191, 191, 191)),
                inactiveLabelStyle: GoogleFonts.roboto(
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