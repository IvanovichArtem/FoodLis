import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KitchenItem extends StatefulWidget {
  final String name;
  final double height;
  final double width;

  const KitchenItem({
    super.key,
    required this.name,
    required this.width,
    required this.height,
  });

  @override
  _KitchenItemState createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    // Просто устанавливаем имя изображения, так как оно теперь берется из assets
    fetchImage();
  }

  // Метод для поиска изображения в assets
  void fetchImage() {
    setState(() {
      // Формируем путь к изображению в assets
      imageUrl = 'assets/images/kitchens/${widget.name}.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl != null)
          GestureDetector(
            onTap: () {
              // Define your action here
              print('Image tapped: ${widget.name}');
              // Example: Navigate to a new screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(name: widget.name)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          CircularProgressIndicator(
            color: Color.fromARGB(255, 243, 175, 79),
          ),
        Text(
          widget.name,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
