import 'package:coinbid/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//
// class PlayAds extends StatefulWidget {
//   final String url;
//   const PlayAds({required this.url ,Key? key}) : super(key: key);
//
//   @override
//   State<PlayAds> createState() => _PlayAdsState();
// }
//
// class _PlayAdsState extends State<PlayAds> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url,
//         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {
//         });
//       });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _controller.value.isInitialized
//           ? AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: <Widget>[
//             VideoPlayer(_controller),
//             const ClosedCaption(text: null),
//             // Here you can also add Overlay capacities
//             VideoProgressIndicator(
//               _controller,
//               allowScrubbing: true,
//               padding: const EdgeInsets.all(3),
//               colors: const VideoProgressColors(
//                   playedColor: kPrimaryColor),
//             ),
//           ],
//         ),
//       )
//           : const SizedBox(
//         height: 250,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink!);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
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
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
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
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);



  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
          },
        ),

      ],
    );
  }
}