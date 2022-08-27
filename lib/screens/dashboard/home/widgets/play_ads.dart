import 'package:coinbid/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerDemo extends StatefulWidget {
  @override
  _VideoPlayerDemoState createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {
  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;
  late List<VideoPlayerController> _controllers;
  List<VoidCallback> _listeners =[];
  List<String> _urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  @override
  void initState() {
    super.initState();

    if (_urls.length > 0) {
      _initController(0).then((_) {
        _playController(0);
      });
    }

    if (_urls.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = _controller(index).value.duration.inMilliseconds;
      int pos = _controller(index).value.position.inMilliseconds;
      int buf = _controller(index).value.buffered.last.end.inMilliseconds;

      setState(() {
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          _nextVideo();
        }
      }
    };
  }

  _controller(int index) {
     return VideoPlayerController.network(_urls[index]);
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(_urls.elementAt(index));
    _controllers[index] = controller;
    await controller.initialize();
  }

  void _removeController(int index) {
    _controller(index).dispose();
    _controllers.remove(_urls.elementAt(index));
    _listeners.remove(index);
  }

  void _stopController(int index) {
    _controller(index).removeListener(_listeners[index]);
    _controller(index).pause();
    _controller(index).seekTo(Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    // if (!_listeners.contains(index)) {
    //   _listeners[index] = _listenerSpawner(index);
    // }
    _controller(index).addListener(_listeners[index]);
    await _controller(index).play();
    setState(() {});
  }

  void _previousVideo() {
    if (_lock || index == 0) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index + 1 < _urls.length) {
      _removeController(index + 1);
    }

    _playController(--index);

    if (index == 0) {
      _lock = false;
    } else {
      _initController(index - 1).whenComplete(() => _lock = false);
    }
  }

  void _nextVideo() async {

    _stopController(index);

    if (index - 1 >= 0) {
      _removeController(index - 1);
    }
    ++index;
    print("scjkbewkfjbe2fouh23iufb34yfg32iuydfg3ioufh3iu    "+index.toString());
    _playController(index);

    if (index == _urls.length - 1) {
      _lock = false;
    } else {
      _initController(index + 1).whenComplete(() => _lock = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing ${index + 1} of ${_urls.length}"),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onLongPressStart: (_) => _controller(index).pause(),
            onLongPressEnd: (_) => _controller(index).play(),
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller(index).value.aspectRatio,
                child: Center(child: VideoPlayer(_controller(index))),
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _buffer,
              color: Colors.grey,
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * _position,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(onPressed: _previousVideo, child: Icon(Icons.arrow_back)),
          SizedBox(width: 24),
          FloatingActionButton(onPressed: _nextVideo, child: Icon(Icons.arrow_forward)),
        ],
      ),
    );
  }
}
class GetVideo extends StatefulWidget {
  const GetVideo({
    required this.videoLink,
  });
  final String? videoLink;

  @override
  _GetVideoState createState() => _GetVideoState();
}

class _GetVideoState extends State<GetVideo> {
  late VideoPlayerController _controller;
  int currentDurationInSecond = 0;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink!);
    _controller.addListener(() {
      setState(() {
        currentDurationInSecond = _controller.value.position.inSeconds;
      });
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {
      loading = false;
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
       child: _controller.value.isInitialized ?
       ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller, second: currentDurationInSecond,),
               // VideoProgressIndicator(_controller, allowScrubbing: false),
              ],
            ),
          ),
        ),
      )
                : const SizedBox(
        height: 250,
        child: Center(
          child: CircularProgressIndicator(
              valueColor:AlwaysStoppedAnimation<Color>(kPrimaryColor)
          ),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key,
    required this.second,
    required this.controller})
      : super(key: key);



  final VideoPlayerController controller;
  final int second ;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
    controller.value.isBuffering ? Container(
          width: double.infinity,
          height: double.infinity,
         // color: Colors.black.withOpacity(.3),
          child: Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          )),
        ):SizedBox(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Center(
                child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Color(0xff484848),
                  size: 30.0,
                  semanticLabel: 'Play',
                ),
            ),
          ),
              ),
        ),
        GestureDetector(
          onTap: () {

            controller.value.isPlaying ? controller.pause() : controller.play();
            controller.value.position.compareTo(controller.value.duration);
          },
        ),

      ],
    );
  }
}