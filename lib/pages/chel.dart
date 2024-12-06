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
      body: Center(
        widthFactor: 1,
        // Изменено выравнивание, чтобы картинка была по центру
        child: SvgPicture.asset(
          'assets/images/error_page.svg',
          height:
              300, // Задал размеры, чтобы изображение не выходило за границы
          semanticsLabel: 'Ошибка', // Альтернативный текст для доступности
          placeholderBuilder: (context) =>
              const CircularProgressIndicator(), // Пока загружается
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

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore SDK
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:video_player/video_player.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:food_lis/widgets/chel/avatar.dart';

// class Chel extends StatefulWidget {
//   final bool isActive; // Флаг активности вкладки

//   const Chel({super.key, required this.isActive});

//   @override
//   State<Chel> createState() => _ChelState();
// }

// class _ChelState extends State<Chel> {
//   late Future<List<Map<String, dynamic>>> _videos;

//   @override
//   void initState() {
//     super.initState();
//     _videos = _fetchVideos();
//   }

//   @override
//   void didUpdateWidget(Chel oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isActive != oldWidget.isActive) {
//       setState(() {}); // Обновляем состояние, если изменяется активность
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchVideos() async {
//     final QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('videos').get();

//     final List<Map<String, dynamic>> videoData = [];
//     for (var doc in snapshot.docs) {
//       final String videoPath = doc['videoPath'];
//       final String videoUrl =
//           await FirebaseStorage.instance.ref(videoPath).getDownloadURL();
//       videoData.add({
//         'videoUrl': videoUrl,
//         'likes': doc['likes'],
//         'comments': doc['comments'],
//         'shared': doc['shared'],
//       });
//     }

//     return videoData.take(5).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _videos,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                   color: Color.fromARGB(255, 244, 160, 15)),
//             );
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Ошибка загрузки видео'));
//           } else {
//             final videos = snapshot.data!;
//             return PageView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: videos.length,
//               itemBuilder: (context, index) {
//                 final video = videos[index];
//                 return VideoPlayerWidget(
//                   videoUrl: video['videoUrl'],
//                   likes: ValueNotifier<int>(
//                       video['likes']), // Инициализация ValueNotifier
//                   comments: ValueNotifier<int>(
//                       video['comments']), // Инициализация ValueNotifier
//                   shared: ValueNotifier<int>(
//                       video['shared']), // Инициализация ValueNotifier
//                   isActive: widget.isActive,
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//   final ValueNotifier<int> likes; // Используем ValueNotifier для изменения
//   final ValueNotifier<int> comments; // Аналогично для комментариев
//   final ValueNotifier<int> shared; // Аналогично для репостов
//   final bool isActive; // Флаг активности вкладки

//   const VideoPlayerWidget({
//     super.key,
//     required this.videoUrl,
//     required this.likes,
//     required this.comments,
//     required this.shared,
//     required this.isActive,
//   });

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
//     with SingleTickerProviderStateMixin {
//   late VideoPlayerController _controller;
//   late AnimationController _likeAnimationController;
//   late Animation<double> _scaleAnimation;
//   bool _isLiked = false;

//   @override
//   void initState() {
//     super.initState();

//     // Инициализация контроллера видео
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         if (widget.isActive) _controller.play();
//         _controller.setLooping(true);
//       });

//     // Инициализация анимации для лайка
//     _likeAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
//       CurvedAnimation(
//         parent: _likeAnimationController,
//         curve: Curves.easeOut,
//       ),
//     );
//   }

//   @override
//   void didUpdateWidget(VideoPlayerWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isActive != oldWidget.isActive) {
//       if (widget.isActive) {
//         _controller.play();
//       } else {
//         _controller.pause();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _likeAnimationController.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//     });
//   }

//   void _onLikePressed() {
//     if (_isLiked) {
//       widget.likes.value--;
//     } else {
//       widget.likes.value++;
//       _likeAnimationController.forward().then((_) {
//         _likeAnimationController.reverse();
//       });
//     }
//     setState(() {
//       _isLiked = !_isLiked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? GestureDetector(
//             onTap: _togglePlayPause,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox.expand(
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     child: SizedBox(
//                       width: _controller.value.size.width,
//                       height: _controller.value.size.height,
//                       child: VideoPlayer(_controller),
//                     ),
//                   ),
//                 ),
//                 if (!_controller.value.isPlaying)
//                   const Icon(
//                     Icons.play_circle_outline_sharp,
//                     color: Color.fromARGB(255, 244, 160, 15),
//                     size: 80,
//                   ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     height: double.infinity,
//                     width: 80,
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(128, 0, 0, 0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ChannelAvatar(imageUrl: 'assets/images/logo.png'),
//                         const SizedBox(height: 20),
//                         Column(
//                           children: [
//                             GestureDetector(
//                               onTap: _onLikePressed,
//                               child: ScaleTransition(
//                                 scale: _scaleAnimation,
//                                 child: AnimatedBuilder(
//                                   animation: widget.likes,
//                                   builder: (context, child) {
//                                     return Icon(
//                                       Icons.favorite,
//                                       color: _isLiked
//                                           ? const Color.fromARGB(
//                                               255, 244, 160, 15)
//                                           : Colors.white,
//                                       size: 40,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             ValueListenableBuilder<int>(
//                               valueListenable: widget.likes,
//                               builder: (context, likes, child) {
//                                 return Text(
//                                   likes.toString(),
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 );
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             SvgPicture.asset('assets/icons/comment.svg'),
//                             ValueListenableBuilder<int>(
//                               valueListenable: widget.comments,
//                               builder: (context, comments, child) {
//                                 return Text(
//                                   comments.toString(),
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 );
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             SvgPicture.asset('assets/icons/share.svg'),
//                             ValueListenableBuilder<int>(
//                               valueListenable: widget.shared,
//                               builder: (context, shared, child) {
//                                 return Text(
//                                   shared.toString(),
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 25),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : const Center(
//             child: CircularProgressIndicator(
//                 color: Color.fromARGB(255, 244, 160, 15)),
//           );
//   }
// }
