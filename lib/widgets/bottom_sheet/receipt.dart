import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ReceiptWidget extends StatefulWidget {
  final double startValue; // Добавляем параметр начального значения
  final double endValue; // Добавляем параметр конечного значения

  const ReceiptWidget({
    super.key,
    required this.startValue, // Обязательные параметры
    required this.endValue,
  });

  @override
  State<ReceiptWidget> createState() => ReceiptWidgetState();
}

class ReceiptWidgetState extends State<ReceiptWidget> {
  late SfRangeValues _values;

  @override
  void initState() {
    super.initState();
    // Инициализация начальных значений диапазона
    _values = SfRangeValues(widget.startValue, widget.endValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 3, vertical: 0), // Добавлено для отступов
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Выравнивание по левому краю
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Средний чек",
              style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SfRangeSliderTheme(
            data: SfRangeSliderThemeData(
                activeLabelStyle: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 191, 191, 191)),
                inactiveLabelStyle: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 191, 191, 191))),
            child: SizedBox(
              width: 370,
              child: SfRangeSlider(
                min: 0,
                max: 60,
                values: _values,
                interval: 15,
                stepSize: 5,
                activeColor: const Color.fromARGB(255, 243, 175, 79),
                showLabels: true,
                showTicks: false,
                thumbShape: _SfThumbShape(),
                labelFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  return actualValue == 60 ? '$formattedText+' : formattedText;
                },
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reset(double receiptStartValue, double receiptEndValue) {
    setState(() {
      _values = SfRangeValues(receiptStartValue, receiptEndValue);
    });
  }

  getCurrentState() {
    return [_values.start, _values.end];
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
