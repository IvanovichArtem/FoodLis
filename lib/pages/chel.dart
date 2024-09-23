import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chel extends StatefulWidget {
  const Chel({super.key});

  @override
  State<Chel> createState() => _ChelState();
}

class _ChelState extends State<Chel> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChelAppBar(),
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
      automaticallyImplyLeading: false,
      title: Text(
        'Пока пусто',
        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
      ),
      actions: const [],
    );
  }
}
