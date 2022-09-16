import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:coinbid/Controllers/video_ads_controller.dart';
import 'package:coinbid/Models/video_ads_model.dart';
import 'package:coinbid/api/http.dart';

import '../../../../api/config.dart';
import '../../../../constant/colors.dart';
import '../../../../provider/getWallet_provider.dart';

class GetVideo extends StatefulWidget {
  GetVideo({
    Key? key,
    required this.videoLink,
    required this.allVideoWatched,
    required this.totaAds,
    required this.onComplete,
    required this.videoIndex,
    this.videoID,
  }) : super(key: key);
  final String? videoLink;
  bool allVideoWatched;
  final String? videoID;
  Function(int)? onComplete;
  int? videoIndex;
  int totaAds;

  @override
  _GetVideoState createState() => _GetVideoState();
}

class _GetVideoState extends State<GetVideo> {
  late VideoPlayerController _controller;
  int currentDurationInSecond = 0;
  int totalLength = 0;

  bool loading = true;
  int videoIndex = 0;
  bool isVideoStarted = true;
  bool isVideoFinished = true;

  bool alreadyStarted = false;
  bool alreadyCompleted = false;
  bool isPlaying = false;

  void initState() {
    widget.onComplete!(widget.videoIndex!.toInt());
    videoIndex = widget.videoIndex!;
    totalLength = widget.totaAds;
    _controller = VideoPlayerController.network("${widget.videoLink}");
    widget.allVideoWatched = false;
    print("Video Address is : ${widget.videoLink}");

    _controller.addListener(statusListener);
    _controller.setLooping(false);
    _controller.initialize().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  void statusListener() {
    final controllerValue = _controller.value;
    setState(() {
      isPlaying = controllerValue.isPlaying;
      controllerValue.buffered;
    });

    int position = controllerValue.position.inMilliseconds;
    int duration = controllerValue.duration.inMilliseconds;

    if (!alreadyStarted && isPlaying && (position == 0 || position < duration))
      return onStarted();
    if (!alreadyCompleted && !isPlaying && position > 0 && position >= duration)
      return onCompleted();
  }

  void onStarted() {
    alreadyStarted = true;
    alreadyCompleted = false;
    //TODO: Video just started
  }

  void onCompleted() {
    alreadyStarted = false;
    alreadyCompleted = true;
    videoIndex++;
    widget.onComplete!(videoIndex);

    print("@@@@@@@@@@@@@@@@@@");
    print(widget.videoID);
    print("video is Complete");
    print("@@@@@@@@@@@@@@@@@@");
    VideoAdsController().watchAdds(id: widget.videoID, context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // Future.delayed(Duration(microseconds: 200), () {
    _controller.dispose();
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("%%%%%% is all videos watched ? : ${widget.allVideoWatched}");

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
                      widget.allVideoWatched
                          ? Container(
                              height: MediaQuery.of(context).size.height * .21,
                              width: MediaQuery.of(context).size.width * .85,
                              color: Colors.grey.withOpacity(.3),
                              child: Center(
                                  child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Icon(
                                  Icons.done_all,
                                  color: Colors.white,
                                ),
                              )),
                            )
                          : Container(),
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
