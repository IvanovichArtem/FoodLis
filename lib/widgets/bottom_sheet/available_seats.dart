import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvailableSeatsInfo extends StatefulWidget {
  final bool isTodaySelected; // Параметр для кнопки "Сегодня"
  final bool isTomorrowSelected; // Параметр для кнопки "Завтра"

  const AvailableSeatsInfo({
    super.key,
    required this.isTodaySelected,
    required this.isTomorrowSelected,
  });

  @override
  State<AvailableSeatsInfo> createState() => _AvailableSeatsInfoState();
}

class _AvailableSeatsInfoState extends State<AvailableSeatsInfo> {
  late bool isTodaySelected;
  late bool isTomorrowSelected;

  @override
  void initState() {
    super.initState();
    // Инициализация состояния значениями из параметров
    isTodaySelected = widget.isTodaySelected;
    isTomorrowSelected = widget.isTomorrowSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Есть свободные столики",
                style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Отступ между заголовком и кнопками
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTodaySelected = !isTodaySelected;
                  });
                },
                child: Container(
                  height: 25,
                  width: 87,
                  decoration: BoxDecoration(
                    color: isTodaySelected
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !isTodaySelected
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // Закругленные края
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Сегодня',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: isTodaySelected
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTomorrowSelected = !isTomorrowSelected;
                  });
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  height: 25,
                  width: 87,
                  decoration: BoxDecoration(
                    color: isTomorrowSelected
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !isTomorrowSelected
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Завтра',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: isTomorrowSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
                width: 157,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 243, 175, 79),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Минимальная ширина для кнопки
                      children: [
                        const Icon(Icons.calendar_today_outlined,
                            size: 17, color: Color.fromARGB(255, 243, 175, 79)),
                        const SizedBox(
                            width: 5), // Отступ между иконкой и текстом
                        Text(
                          'Указать дату',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: const Color.fromARGB(255, 243, 175, 79),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
