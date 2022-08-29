import 'package:coinbid/Controllers/video_ads_controller.dart';
import 'package:coinbid/Models/video_ads_model.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../api/config.dart';
import '../../../../constant/colors.dart';
import '../../../../provider/getWallet_provider.dart';

class GetVideo extends StatefulWidget {
  GetVideo({
    Key? key,
    required this.videoModel,
    this.onComplete,
  }) : super(key: key);
  final VideoAdsModel? videoModel;
  Function(int)? onComplete;

  @override
  _GetVideoState createState() => _GetVideoState();
}

class _GetVideoState extends State<GetVideo> {
  late VideoPlayerController _controller;
  int currentDurationInSecond = 0;
  int totalLength = 0;
  bool loading = true;
  int videoIndex = 0;
  @override
  void initState() {
    super.initState();
    startVideo();
  }

  startVideo() {
    _controller = VideoPlayerController.network(
        "${widget.videoModel?.videos?[videoIndex].video!}");
    _controller.addListener(() {
      setState(() {
        widget.onComplete!(videoIndex);
        currentDurationInSecond = _controller.value.position.inSeconds;
        totalLength = _controller.value.duration.inSeconds;
        // if (videoIndex <= widget.videoModel!.videos!.length) {

        // nextVideo();

        if (_controller.value.isPlaying) {
          if (currentDurationInSecond == totalLength - 1) {
            print("BOOOOOOOOOOOO $videoIndex OOOOOOOOOOOM");
            nextVideo();
            // print("BOOOOOOOOOOOOOOOOOOOOOOOM");
          }
        }
        // _controller = VideoPlayerController.network(
        //     "${widget.videoModel?.videos?[1].video!}");

        // }
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

  nextVideo() async {
    videoIndex++;
    print("Next Video has initliaeed");
    _controller = await VideoPlayerController.network(
        "${widget.videoModel?.videos?[videoIndex].video!}");

    _controller.addListener(() {
      setState(() {
        currentDurationInSecond = _controller.value.position.inSeconds;
        totalLength = _controller.value.duration.inSeconds;
        // if (videoIndex <= widget.videoModel!.videos!.length) {

        // nextVideo();

        if (_controller.value.isPlaying) {
          if (videoIndex + 1 <= widget.videoModel!.videos!.length - 1) {
            if (currentDurationInSecond == totalLength - 1) {
              nextVideo();

              VideoAdsController()
                  .watchAdds(id: widget.videoModel?.videos?[videoIndex].id);
              widget.onComplete!(videoIndex);
            }
          } else if (videoIndex >= widget.videoModel!.videos!.length - 1) {
            print("You have watched all adds");
          }
        }
        // _controller = VideoPlayerController.network(
        //     "${widget.videoModel?.videos?[1].video!}");

        // }
      });
    });

    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_controller),
                      _ControlsOverlay(
                        controller: _controller,
                        second: currentDurationInSecond,
                      ),
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
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
              ),
            ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay(
      {Key? key, required this.second, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;
  final int second;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        controller.value.isBuffering
            ? Container(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.black.withOpacity(.3),
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white))),
              )
            : SizedBox(),
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
                        color: Colors.white),
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
