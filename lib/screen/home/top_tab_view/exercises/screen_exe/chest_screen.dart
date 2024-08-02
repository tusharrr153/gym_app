import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'dart:async'; // Import for Timer

class ChestScreen extends StatefulWidget {
  const ChestScreen({Key? key}) : super(key: key);

  @override
  _ChestScreenState createState() => _ChestScreenState();
}

class _ChestScreenState extends State<ChestScreen> {
  final List<Map<String, String>> chestExercises = [
    {
      'name': 'Pushup',
      'image': 'assets/img/pushup.jpeg',
      'video': 'pushup'
    },
    // Add more exercises here
  ];

  Future<String> getVideoUrl(String videoName) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('chest_exercise/$videoName.mp4');
      return await ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Exercises'),
      ),
      body: ListView.builder(
        itemCount: chestExercises.length,
        itemBuilder: (context, index) {
          final exercise = chestExercises[index];
          return Card(
            child: ListTile(
              leading: Image.asset(exercise['image']!),
              title: Text(exercise['name']!),
              onTap: () async {
                final videoUrl = await getVideoUrl(exercise['video']!);
                if (videoUrl.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  Timer? _hideTimer;
  double _videoProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown
        _controller.addListener(() {
          setState(() {
            _videoProgress = _controller.value.position.inMilliseconds.toDouble();
          });
        });
      });
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _onPlayPauseButtonPressed() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControls = true;
      } else {
        _controller.play();
        _showControls = false;
      }
      _startHideControlsTimer(); // Reset the timer when button pressed
    });
  }

  void _onForwardButtonPressed() {
    final newPosition = _controller.value.position + Duration(seconds: 10);
    _controller.seekTo(newPosition < _controller.value.duration ? newPosition : _controller.value.duration);
    _startHideControlsTimer(); // Reset the timer when button pressed
  }

  void _onBackwardButtonPressed() {
    final newPosition = _controller.value.position - Duration(seconds: 10);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
    _startHideControlsTimer(); // Reset the timer when button pressed
  }

  void _onSeekBarChanged(double value) {
    _controller.seekTo(Duration(milliseconds: value.toInt()));
    _startHideControlsTimer(); // Reset the timer when seek bar changed
  }

  void _startHideControlsTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (_controller.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = _controller.value.duration;
    final position = _controller.value.position;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Video'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            if (_showControls)
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showControls = true;
                      _startHideControlsTimer(); // Reset timer on user interaction
                    });
                  },
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.replay_10, color: Colors.white),
                              onPressed: _onBackwardButtonPressed,
                            ),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: _onPlayPauseButtonPressed,
                            ),
                            IconButton(
                              icon: Icon(Icons.forward_10, color: Colors.white),
                              onPressed: _onForwardButtonPressed,
                            ),
                          ],
                        ),
                        Slider(
                          value: _videoProgress,
                          min: 0.0,
                          max: duration.inMilliseconds.toDouble(),
                          onChanged: _onSeekBarChanged,
                          activeColor: Colors.red,
                          inactiveColor: Colors.white54,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_formatDuration(position)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${_formatDuration(duration)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
