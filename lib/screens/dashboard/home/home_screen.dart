import 'package:coinbid/Controllers/video_ads_controller.dart';
import 'package:coinbid/Models/banner_model.dart';
import 'package:coinbid/provider/banner_provider.dart';
import 'package:coinbid/provider/user_provider.dart';
import 'package:coinbid/provider/video_ads_provider.dart';
import 'package:coinbid/screens/dashboard/home/exchange_coin.dart';
import 'package:coinbid/screens/dashboard/home/widgets/addOpenAdsManager.dart';
import 'package:coinbid/screens/dashboard/home/widgets/carosel_slider.dart';
import 'package:coinbid/screens/dashboard/home/widgets/google_ads_slider.dart';
import 'package:coinbid/screens/dashboard/home/widgets/play_ads.dart';
import 'package:coinbid/screens/dashboard/home/widgets/price_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/page_controller.dart';
import '../../../constant/colors.dart';
import '../../../provider/getWallet_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxAttempts = 3;
// --------------------------------

  late BannerAd staticAd;
  bool staticAdLoaded = false;
  late BannerAd inlineAd;
  bool inlineAdLoaded = false;

  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;

  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;
  String sampleID = "ca-app-pub-3940256099942544/1033173712";
  String bannerID = "ca-app-pub-3940256099942544/6300978111";
  String openAppID = "ca-app-pub-3940256099942544/3419835294";
  String interstileID = "ca-app-pub-3940256099942544/1033173712";
  String rewardedID = "ca-app-pub-3940256099942544/8691691433";

  ///Ad request settings
  static const AdRequest request = AdRequest(
      // keywords: ['', ''],
      // contentUrl: '',
      // nonPersonalizedAds: false,
      );

  ///function to load static banner ad
  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: bannerID,
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            staticAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('ad failed to load ${error.message}');
        }));

    staticAd.load();
  }

  ///function to load inline banner ad
  void loadInlineBannerAd() {
    inlineAd = BannerAd(
        adUnitId: sampleID,
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            inlineAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('ad failed to load ${error.message}');
        }));

    inlineAd.load();
  }

  ///function to create Interstitial ad
  void createInterstialAd() {
    InterstitialAd.load(
        adUnitId: interstileID,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAttempts = 0;
        }, onAdFailedToLoad: (error) {
          interstitialAttempts++;
          interstitialAd = null;
          print('falied to load Inerstile ads ======> ${error.message}');

          if (interstitialAttempts <= maxAttempts) {
            createInterstialAd();
          }
        }));
  }

  ///function to show the Interstitial ad after loading it
  ///this function will get called when we click on the button
  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('trying to show before loading');
      return;
    }

    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('failed to show the ad $ad');

          createInterstialAd();
        });

    interstitialAd!.show();
    interstitialAd = null;
  }

  ///function to create rewarded ad
  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedID,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        }, onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;
          print('failed to load ${error.message}');

          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        }));
  }

  ///function to show the rewarded ad after loading it
  ///this function will get called when we click on the button
  void showRewardedAd() {
    if (rewardedAd == null) {
      print('trying to show before loading');
      return;
    }

    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('failed to show the ad $ad');

          createRewardedAd();
        });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print('reward video ${reward.amount} ${reward.type}');
    });
    rewardedAd = null;
  }

  // -------------------------------
  String? userName;
  bool? watched;
  Future<String?> readDataFromHive() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-name");
    bool? watch = box.get("is-ads-watched");
    watched = watch;
    userName = data.toString();

    return data;
  }

  // AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;

  @override
  void initState() {
    loadStaticBannerAd();
    loadInlineBannerAd();
    createInterstialAd();
    createRewardedAd();
    super.initState();

    Future.delayed(Duration.zero, () {
      // appOpenAdManager.showAdIfAvailable();
      // appOpenAdManager.loadAd();

      readDataFromHive();
      final dataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      dataProvider.getData();
      Provider.of<GetBannersProvider>(context, listen: false).getBanners();
      Provider.of<GetWalletProvider>(context, listen: false).getwallet();
      Provider.of<VideoAdsProvider>(context, listen: false).getVideoAds();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    staticAd.dispose();
    inlineAd.dispose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();
  }

  int counterIndex = 0;
  bool allVideoWatched = false;
  double? counterPercentage = 0.0;
  double? totalAds = 0;
  void calculate({int? totalLength, curentLength}) {
    if (totalLength != null && curentLength != null) {
      totalAds = totalLength.toDouble();
      var percentage = curentLength / totalLength;
      counterPercentage = percentage;
    }
  }

  Future<void> isAdswatched(bool ads) async {
    var box = await Hive.openBox("UserData");
    var data = box.put("is-ads-watched", ads);
    // token = data.toString();
  }

  bool firstAd = false;

  VideoAdsController videoAdsController = VideoAdsController();

  @override
  Widget build(BuildContext context) {
    final walletProvider =
        Provider.of<GetWalletProvider>(context, listen: true).getWalletModel;
    final totalAds = Provider.of<GetWalletProvider>(context, listen: true)
        .getWalletModel
        ?.wallets
        ?.total_ads;

    final walletLoading =
        Provider.of<GetWalletProvider>(context, listen: false).isLoading;
    // print("wallet Provider : ${walletProvider?.wallets?.counter}");

    final dataProvider =
        Provider.of<UserDataProvider>(context).getUserModel?.users;
    BannerModel? banners =
        Provider.of<GetBannersProvider>(context, listen: false).bannerModel;
    // print("Title of first Banner ${banners?.banners?.last.image}");

    final videoAdsProvider =
        Provider.of<VideoAdsProvider>(context, listen: true).videoAdsModel;
    print("Video Ads @@@@@@@@@@ ---> ${videoAdsProvider?.videos}");

    final isLoading =
        Provider.of<VideoAdsProvider>(context, listen: true).isLoading;

    // counter = walletProvider!.wallets!.counter!.toInt();
    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;

    calculate(
      totalLength: totalAds,
      curentLength: walletProvider?.wallets?.counter,
    );
    if (videoAdsProvider != null) {
      videoAdsController.isAdswatched(false);
    }

    if (walletProvider?.wallets?.counter != null && totalAds != null) {
      if (walletProvider?.wallets?.counter == totalAds ||
          counterIndex == totalAds) {
        setState(() {
          counterIndex = totalAds;

          // Future.delayed(Duration(microseconds: 200), () {
          allVideoWatched = true;
        });
        isAdswatched(true);
        // });
      }
    } else {
      setState(() {
        isAdswatched(false);
      });
    }

    // if (totalAds==counterIndex) {
    //   setState(() {
    //     allVideoWatched = true;
    //     counterPercentage = 1;
    //   });
    // }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: h * .06),
            Row(
              children: [
                 CircleAvatar(
                  radius: 25,
                  backgroundColor: kLightBackgroundColor,
                  backgroundImage: dataProvider?.profile != null ?NetworkImage(dataProvider?.profile??''):null,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: dataProvider?.profile == null ? const  ClipOval(
                      child: Image(
                        image: AssetImage('images/profile.png'),
                        width: 20,
                      ),
                    ):SizedBox(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dataProvider?.name != null
                        ? SizedBox(
                          width: w*.6,
                          child: Text(
                              '${dataProvider?.name}',
                              overflow: TextOverflow.ellipsis,
                              // "${userName}",
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                        )
                        : Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                    Text(
                      "Good Morning!",
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kTextColor),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: kBorderColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Image(
                        image: AssetImage('images/notification.png'),
                        width: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * .015),
            walletLoading
                ? Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: PriceBox(
                        boxColor: kOrangeColor,
                        url: 'images/curency.png',
                        price: '\$ ${walletProvider?.wallets?.price}',
                        title: 'Total Cash',
                        function: () {
                          Navigator.of(context).push(PageCreateRoute()
                              .createRoute(const ExchangeCoinScreen()));
                          // Get.to(const ExchangeCoinScreen());
                        },
                      )),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: PriceBox(
                        boxColor: kSecondaryColor,
                        url: 'images/star.png',
                        price: '${walletProvider?.wallets?.coins}',
                        title: 'Total Coins',
                        function: () {},
                      ))
                    ],
                  ),
            SizedBox(height: h * .015),
            CustomIndicator(
              bannerModel: banners,
            ),
            SizedBox(height: h * .015),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showRewardedAd();
                  },
                  child: Text(
                    "Watch Ads",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                const Spacer(),
                Text(
                  "(${counterIndex}/${totalAds != null ? totalAds : "0"})",
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff946C52)),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 70,
                    height: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: counterPercentage,
                        valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor),
                        backgroundColor: Color(0xffFDEEE4),
                      ),
                    )),
              ],
            ),
            SizedBox(height: h * .015),
            Stack(
              children: [
                Container(
                    height: h * .23,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: videoAdsProvider?.videos?.length != null &&
                            totalAds != null &&
                            walletProvider?.wallets?.counter?.toInt() != null &&
                            counterIndex != totalAds
                        ? GetVideo(
                            videoIndex:
                                walletProvider?.wallets?.counter?.toInt(),
                            totaAds: totalAds,
                            videoLink: videoAdsProvider
                                ?.videos?[
                                    walletProvider!.wallets!.counter!.toInt()]
                                .video,
                            allVideoWatched: allVideoWatched ? true : false,
                            videoID: videoAdsProvider
                                ?.videos?[
                                    walletProvider!.wallets!.counter!.toInt()]
                                .id,
                            onComplete: (isComplete) {
                              Future.delayed(Duration.zero, () async {
                                setState(() {
                                  counterIndex = isComplete;
                                  print("Is video Complete : $isComplete");
                                  // Provider.of<GetWalletProvider>(context,
                                  //         listen: false)
                                  //     .getwallet();
                                });
                              });
                            },
                          )
                        : allVideoWatched
                            ? completeWdiget(context)
                            : Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red)),
                              )),

                // if first ad not watched
                firstAd != true
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            print("BAAAAAAAAAAAAAAM!");
                            firstAd = true;
                          });
                          showRewardedAd();
                        },
                        child: Container(
                          height: h * .23,
                          width: double.infinity,
                          color: Colors.transparent,
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: h * .017),
            if (staticAdLoaded)
              if (staticAdLoaded)
                Container(
                  child: AdWidget(
                    ad: staticAd,
                  ),
                  width: staticAd.size.width.toDouble(),
                  height: staticAd.size.height.toDouble(),
                  alignment: Alignment.bottomCenter,
                ),
            // const GoogleAdsBanner(),
          ],
        ),
      ),
    );
  }
}

Widget completeWdiget(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * .21,
    width: MediaQuery.of(context).size.width * .85,
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Container(
          height: 50,
          width: 50,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          child: Icon(
            Icons.done_all,
            color: Colors.white,
          ),
        )),
        SizedBox(
          height: 5,
        ),
        Text(
          "You've watched all",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
