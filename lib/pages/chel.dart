import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chel extends StatefulWidget {
  const Chel({super.key});

  @override
  State<Chel> createState() => _ChelState();
}

class _ChelState extends State<Chel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChelAppBar(),
      body: SizedBox(
        height: double.infinity,
        // Изменено выравнивание, чтобы картинка была по центру
        child: SvgPicture.asset(
          alignment: Alignment.center, 'assets/images/error_page.svg',
          height:
              300, // Задал размеры, чтобы изображение не выходило за границы
          semanticsLabel: 'Ошибка', // Альтернативный текст для доступности
          placeholderBuilder: (context) => const CircularProgressIndicator(
            color: Color.fromARGB(255, 243, 175, 79),
          ), // Пока загружается
        ),
      ),
    );
  }
}

class ChelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChelAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back), // Кнопка назад
      //   onPressed: () {
      //     Navigator.pop(context); // Возврат к предыдущему экрану
      //   },
      // ),
      // title: const Text('Ошибка'), // Заголовок AppBar
      // centerTitle: true, // Выравнивание заголовка по центру
    );
  }
}
