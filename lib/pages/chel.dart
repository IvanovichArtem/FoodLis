import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';

class Chel extends StatefulWidget {
  const Chel({super.key});

  @override
  State<Chel> createState() => _ChelState();
}

class _ChelState extends State<Chel> {
  late Future<List<String>> _videoUrls;

  @override
  void initState() {
    super.initState();
    _videoUrls = _fetchVideoUrls();
  }

  Future<List<String>> _fetchVideoUrls() async {
    final storageRef = FirebaseStorage.instance.ref().child('videos');
    final ListResult result = await storageRef.listAll();

    // Берём ровно 5 видео, если доступно меньше - используем доступные
    final List<Reference> allFiles = result.items.take(5).toList();

    // Ссылки на видео
    final List<String> videoUrls = [];
    for (var file in allFiles) {
      final url = await file.getDownloadURL();
      videoUrls.add(url);
    }
    return videoUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _videoUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки видео'));
          } else {
            final videoUrls = snapshot.data!;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return VideoPlayerWidget(videoUrl: videoUrls[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Автоматическое воспроизведение
        _controller.setLooping(true); // Повторное воспроизведение
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? GestureDetector(
              onTap:
                  _togglePlayPause, // Включаем/остановливаем видео по нажатию
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  if (!_controller
                      .value.isPlaying) // Иконка паузы, если видео остановлено
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: const Icon(
                        Icons.play_circle_outline_sharp,
                        color: Colors.orange,
                        size: 80,
                      ),
                    ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
    );
  }
}
