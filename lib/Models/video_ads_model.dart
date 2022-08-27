class VideoAdsModel {
  VideoAdsModel({
    this.success,
    this.videos,
  });

  bool? success;
  List<VideoAds>? videos;

  factory VideoAdsModel.fromJson(Map<String, dynamic> json) => VideoAdsModel(
    success: json["success"],
    videos: List<VideoAds>.from(json["videos"].map((x) => VideoAds.fromJson(x))),
  );
}

class VideoAds {
  VideoAds({
    this.id,
    this.title,
    this.video,
    this.coins,
    this.v,
  });

  String? id;
  String? title;
  String? video;
  String? coins;
  int? v;

  factory VideoAds.fromJson(Map<String, dynamic> json) =>
      VideoAds(
        id: json["_id"],
        title: json["title"],
        video: json["video"],
        coins: json["coins"],
        v: json["__v"],
      );

}
