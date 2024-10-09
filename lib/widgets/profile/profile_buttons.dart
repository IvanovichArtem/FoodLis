import 'package:flutter/material.dart';
import 'package:food_lis/widgets/profile/logout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileButtons extends StatefulWidget {
  const ProfileButtons({super.key});

  @override
  State<ProfileButtons> createState() => _ProfileButtonsState();
}

class _ProfileButtonsState extends State<ProfileButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                CustomListButton(
                    text: 'История посещений',
                    icon: FontAwesomeIcons.clipboard,
                    onPressed: () => {}),
                const Padding(
                  padding: EdgeInsets.fromLTRB(52, 0, 16, 0),
                  child: Divider(
                      height: 2, color: Color.fromARGB(255, 235, 235, 235)),
                ),
                CustomListButton(
                    text: 'Друзья',
                    icon: Icons.group_outlined,
                    onPressed: () => {}),
                const Padding(
                  padding: EdgeInsets.fromLTRB(52, 0, 16, 0),
                  child: Divider(
                      height: 2, color: Color.fromARGB(255, 235, 235, 235)),
                ),
                CustomListButton(
                    text: 'Списки',
                    icon: FontAwesomeIcons.bookmark,
                    onPressed: () => {}),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                CustomListButton(
                    text: 'Помощь',
                    icon: FontAwesomeIcons.circleQuestion,
                    onPressed: () => {}),
                const Padding(
                  padding: EdgeInsets.fromLTRB(52, 0, 16, 0),
                  child: Divider(
                      height: 2, color: Color.fromARGB(255, 235, 235, 235)),
                ),
                CustomListButton(
                    text: 'Друзья',
                    icon: FontAwesomeIcons.phone,
                    onPressed: () => {}),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              LogoutRow(),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Версия 1.0",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 175, 175, 175)),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomListButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  static const Color mainColor = Color.fromARGB(255, 114, 114, 114);

  const CustomListButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Прозрачный цвет для Material
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.grey.withOpacity(0.3), // Цвет волны
        highlightColor: Colors.transparent, // Убираем стандартное выделение
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 13, 20, 10),
          child: Row(
            children: [
              FaIcon(
                icon,
                color: mainColor,
                size: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(
                    color: mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: mainColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
