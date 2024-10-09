import 'package:flutter/material.dart';
import 'package:food_lis/widgets/bottom_sheet/receipt.dart';
import 'package:food_lis/widgets/bottom_sheet/kitchens.dart';
import 'package:food_lis/widgets/bottom_sheet/restaraunt_type.dart';
import 'package:food_lis/widgets/bottom_sheet/distance.dart';
import 'package:food_lis/widgets/bottom_sheet/delivery_info.dart';
import 'package:food_lis/widgets/bottom_sheet/available_seats.dart';
import 'package:food_lis/widgets/bottom_sheet/dinner.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return _BottomSheetContent();
    },
  );
}

class _BottomSheetContent extends StatefulWidget {
  @override
  __BottomSheetContentState createState() => __BottomSheetContentState();
}

class __BottomSheetContentState extends State<_BottomSheetContent> {
  // Начальные состояния виджетов
  double receiptStartValue = 10.0;
  double receiptEndValue = 20.0;
  bool isYandexSelected = false;
  bool isDeliverySelected = false;
  bool isRestaurantSelected = false;
  bool isTodaySelected = false;
  bool isTomorrowSelected = false;

  // Метод для сброса состояний
  void resetStates() {
    setState(() {
      // Сброс всех состояний к начальным значениям
      isYandexSelected = false;
      isDeliverySelected = false;
      isRestaurantSelected = false;
      isTodaySelected = false;
      isTomorrowSelected = false;
      receiptStartValue = 10.0; // Начальное значение
      receiptEndValue = 20.0; // Начальное значение
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Черная фигнюшка
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Контент внутри модального окна
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Передаем состояния в ReceiptWidget
                  ReceiptWidget(
                    startValue: receiptStartValue,
                    endValue: receiptEndValue,
                  ),
                  const KitchensFilterWidget(),
                  RestarauntTypeWidget(
                    // Обновите этот виджет для использования передачи состояния
                    buttonsData: [
                      {'name': 'Ресторан', 'isSelected': isRestaurantSelected},
                      {'name': 'Кафе', 'isSelected': false},
                      {'name': 'Бар', 'isSelected': false},
                      {'name': 'Караоке', 'isSelected': false},
                      {'name': 'Чайная', 'isSelected': false},
                      {'name': 'Пекарня', 'isSelected': false},
                      {'name': 'Кальян', 'isSelected': false},
                      {'name': 'Бабл ти', 'isSelected': false},
                    ],
                  ),
                  const DistanceWidget(),
                  DeliveryInfo(
                    isYandexSelected: isYandexSelected,
                    isDeliverySelected: isDeliverySelected,
                    isRestaurantSelected: isRestaurantSelected,
                  ),
                  AvailableSeatsInfo(
                    isTodaySelected: isTodaySelected,
                    isTomorrowSelected: isTomorrowSelected,
                  ),
                  const DinnerInfo(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          // Кнопки внизу
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), // Отступы снизу
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: resetStates, // Сброс состояний при нажатии
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 243, 175, 79),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Center(
                        child: Text(
                          "Сбросить",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 243, 175, 79),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      // Логика для кнопки "Применить"
                      // Добавьте здесь логику применения изменений
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Изменения применены!")),
                      ),
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 175, 79),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Center(
                        child: Text(
                          "Применить",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
