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
      return _buildBottomSheet(context);
    },
  );
}

Widget _buildBottomSheet(BuildContext context) {
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
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReceiptWidget(),
                KitchensFilterWidget(),
                RestarauntTypeWidget(),
                DistanceWidget(),
                DeliveryInfo(),
                AvailableSeatsInfo(),
                DinnerInfo(),
                SizedBox(height: 5),
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
                const SizedBox(
                  height: 5,
                ),
                OutlinedButton(
                  onPressed: () => {},
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
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 243, 175, 79),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 175, 79),
                  ),
                  child: SizedBox(
                    width: 110,
                    child: Center(
                      child: Text(
                        "Применить",
                        style: GoogleFonts.roboto(
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
