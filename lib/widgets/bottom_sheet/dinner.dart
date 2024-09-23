import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/bottom_sheet/custom_toogle_switch.dart';

class DinnerInfo extends StatefulWidget {
  const DinnerInfo({super.key});

  @override
  State<DinnerInfo> createState() => _DinnerInfoState();
}

class _DinnerInfoState extends State<DinnerInfo> {
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
                style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const CustomToggleSwitch(),
            ],
          ),
        ],
      ),
    );
  }
}
