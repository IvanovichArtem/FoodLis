import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore SDK
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';

class Chel extends StatefulWidget {
  const Chel({super.key});

  @override
  State<Chel> createState() => _ChelState();
}

class _ChelState extends State<Chel> {
  late Future<List<Map<String, dynamic>>> _videos;

  @override
  void initState() {
    super.initState();
    _videos = _fetchVideos();
  }

  Future<List<Map<String, dynamic>>> _fetchVideos() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('videos').get();

    // Список видео с метаданными
    final List<Map<String, dynamic>> videoData = [];
    for (var doc in snapshot.docs) {
      final String videoPath = doc['videoPath'];
      final String videoUrl =
          await FirebaseStorage.instance.ref(videoPath).getDownloadURL();
      videoData.add({
        'videoUrl': videoUrl,
        'likes': doc['likes'],
        'comments': doc['comments'],
        'shared': doc['shared'],
      });
    }

    // Вернуть не более 5 видео
    return videoData.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _videos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки видео'));
          } else {
            final videos = snapshot.data!;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return VideoPlayerWidget(
                  videoUrl: video['videoUrl'],
                  likes: video['likes'],
                  comments: video['comments'],
                  shared: video['shared'],
                );
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
  final int likes;
  final int comments;
  final int shared;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.likes,
    required this.comments,
    required this.shared,
  });

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
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.white,
      ),
      body: _controller.value.isInitialized
          ? GestureDetector(
              onTap:
                  _togglePlayPause, // Включаем/остановливаем видео по нажатию
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Видео
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
                  // Иконка паузы, если видео остановлено
                  if (!_controller.value.isPlaying)
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: const Icon(
                        Icons.play_circle_outline_sharp,
                        color: Colors.orange,
                        size: 80,
                      ),
                    ),
                  // Блок с кнопками лайков, комментариев и шаринга
                  Align(
                    alignment:
                        Alignment(1, 0.2), // Правый край экрана, по центру
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Лайки
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.white),
                              iconSize: 40,
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                            Text(
                              '${widget.likes}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Отступ между кнопками
                        // Комментарии
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.comment, color: Colors.white),
                              iconSize: 40,
                              onPressed: () {
                                // Логика для комментариев
                              },
                            ),
                            Text(
                              '${widget.comments}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Отступ между кнопками
                        // Поделиться
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share, color: Colors.white),
                              iconSize: 40,
                              onPressed: () {
                                // Логика для шаринга
                              },
                            ),
                            Text(
                              '${widget.shared}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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
