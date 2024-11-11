import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AvailableSeatsInfo extends StatefulWidget {
  final bool isTodaySelected;
  final bool isTomorrowSelected;

  const AvailableSeatsInfo({
    super.key,
    required this.isTodaySelected,
    required this.isTomorrowSelected,
  });

  @override
  State<AvailableSeatsInfo> createState() => AvailableSeatsInfoState();
}

class AvailableSeatsInfoState extends State<AvailableSeatsInfo> {
  late bool isTodaySelected;
  late bool isTomorrowSelected;
  String selectedDateText = 'Указать дату';

  @override
  void initState() {
    super.initState();
    isTodaySelected = widget.isTodaySelected;
    isTomorrowSelected = widget.isTomorrowSelected;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale('ru'),
    );
    if (picked != null) {
      setState(() {
        selectedDateText = DateFormat('dd.MM.yyyy', 'ru').format(picked);
      });
    }
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
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                    borderRadius: BorderRadius.circular(10),
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
                  onPressed: () => _selectDate(context),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 17, color: Color.fromARGB(255, 243, 175, 79)),
                      const SizedBox(width: 5),
                      Text(
                        selectedDateText,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: const Color.fromARGB(255, 243, 175, 79),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void reset() {
    setState(() {
      isTodaySelected = false;
      isTomorrowSelected = false;
      selectedDateText = 'Указать дату';
    });
  }

  getCurrentState() {
    return {
      'isTodaySelected': isTodaySelected,
      'isTomorrowSelected': isTomorrowSelected,
      'selectedDate':
          (selectedDateText == "Указать дату") ? null : selectedDateText
    };
  }
}
