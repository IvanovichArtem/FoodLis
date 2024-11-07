import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/bottom_sheet/custom_toogle_switch.dart';

class DinnerInfo extends StatefulWidget {
  const DinnerInfo({super.key});

  @override
  State<DinnerInfo> createState() => DinnerInfoState();
}

class DinnerInfoState extends State<DinnerInfo> {
  final ValueNotifier<bool> isSelectedNotifier = ValueNotifier(false);

  @override
  void dispose() {
    isSelectedNotifier.dispose(); // Освобождаем ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Обеденное меню",
                style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              CustomToggleSwitch(isSelectedNotifier: isSelectedNotifier),
            ],
          ),
        ],
      ),
    );
  }

  void reset() {
    isSelectedNotifier.value = false; // Сбрасываем состояние переключателя
  }

  getCurrentState() {
    return {'haveLanch': isSelectedNotifier.value};
  }
}
