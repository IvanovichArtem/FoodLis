import 'package:flutter/material.dart';

class ChannelAvatar extends StatefulWidget {
  final String imageUrl; // URL аватара
  final double size; // Размер аватара
  const ChannelAvatar({Key? key, required this.imageUrl, this.size = 60.0})
      : super(key: key);

  @override
  _ChannelAvatarState createState() => _ChannelAvatarState();
}

class _ChannelAvatarState extends State<ChannelAvatar>
    with SingleTickerProviderStateMixin {
  bool isSubscribed = false; // Состояние подписки
  late AnimationController _controller;
  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _iconColorAnimation;

  @override
  void initState() {
    super.initState();

    // Настраиваем анимацию
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _borderColorAnimation = ColorTween(
      begin: Color.fromARGB(255, 244, 160, 15), // Цвет обводки до подписки
      end: Color.fromARGB(255, 244, 160, 15), // Цвет обводки после подписки
    ).animate(_controller);

    _iconColorAnimation = ColorTween(
      begin: Colors.white, // Цвет обводки до подписки
      end: Colors.white, // Цвет иконки после подписки
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSubscription() {
    setState(() {
      isSubscribed = !isSubscribed;
      if (isSubscribed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSubscription,
      child: Container(
        padding: EdgeInsets.only(
            bottom: widget.size * 0.15), // Добавляем отступ снизу
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none, // Разрешаем элементы выходить за границы
          children: [
            AnimatedBuilder(
              animation: _borderColorAnimation,
              builder: (context, child) {
                return Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _borderColorAnimation.value!,
                      width: 4.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: -widget.size * 0.10, // Перемещаем иконку ниже
              child: AnimatedBuilder(
                animation: _iconColorAnimation,
                builder: (context, child) {
                  return Container(
                    width: widget.size * 0.3,
                    height: widget.size * 0.3,
                    decoration: BoxDecoration(
                      color: isSubscribed
                          ? Color.fromARGB(255, 244, 160, 15)
                          : Color.fromARGB(255, 244, 160, 15), // Цвет кнопки
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 244, 160, 15),
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      isSubscribed
                          ? Icons.check
                          : Icons.add, // Галочка или плюс
                      color: _iconColorAnimation.value,
                      size: widget.size * 0.24,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
