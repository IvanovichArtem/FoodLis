import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutRow extends StatelessWidget {
  const LogoutRow({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showLogoutDialog(context); // Обрабатывает нажатие на всю кнопку
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Убираем отступы
        overlayColor: (Colors.transparent), // Убираем эффект нажатия
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Иконка выхода
          const FaIcon(
            FontAwesomeIcons.arrowRightFromBracket,
            color: Color.fromARGB(255, 114, 114, 114),
            size: 16,
          ),
          const SizedBox(
            width: 5, // Можно уменьшить или убрать отступ
          ),
          // Текст "Выйти"
          Text(
            "Выйти",
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 114, 114, 114),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Функция для отображения диалога подтверждения выхода
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Подтверждение выхода"),
          content: const Text("Вы уверены, что хотите выйти?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text("Отмена"),
            ),
            TextButton(
              onPressed: () async {
                // Выход из Firebase
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Закрыть диалог
                // Дополнительные действия, например, переход на страницу логина
              },
              child: const Text("Выйти"),
            ),
          ],
        );
      },
    );
  }
}
