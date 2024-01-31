import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:vpn_basic_project/helpers/config.dart';

class AudienceAddvertisement {
  static bool isInterstitialAdLoaded = false;
  static bool isRewardedAdLoaded = false;

  static Future<void> loadInterstitialAddvertisement() async {
    await FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: Config.fbint,
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isInterstitialAdLoaded = false;
          loadInterstitialAddvertisement();
        }
      },
    );
  }

  static Future<void> loadRewardedVideoAd() async {
    await FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "IMG_16_9_APP_INSTALL#549167759165615_549192132496511",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          isRewardedAdLoaded = false;
          loadRewardedVideoAd();
        }
      },
    );
  }
}


//***************at imple time*****************

//FacebookInterstitialAd.showInterstitialAd();


// Container(
//                       child: controller.currentAd = FacebookBannerAd(
// placementId: "YOUR_PLACEMENT_ID",
//                     placementId: StringCommon.bannerAndroidAdmobAdId,
// "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
//                     bannerSize: BannerSize.STANDARD,
//                     listener: (result, value) {
//                       print("Banner Ad: $result -->  $value");
//                     },
//                   )),




//native

// FacebookNativeAd(
//   placementId: "YOUR_PLACEMENT_ID",
//   adType: NativeAdType.NATIVE_AD,
//   width: double.infinity,
//   height: 300,
//   backgroundColor: Colors.blue,
//   titleColor: Colors.white,
//   descriptionColor: Colors.white,
//   buttonColor: Colors.deepPurple,
//   buttonTitleColor: Colors.white,
//   buttonBorderColor: Colors.white,
//   keepAlive: true, //set true if you do not want adview to refresh on widget rebuild
//   keepExpandedWhileLoading: false, // set false if you want to collapse the native ad view when the ad is loading 
//   expandAnimationDuraion: 300, //in milliseconds. Expands the adview with animation when ad is loaded
//   listener: (result, value) {
//     print("Native Ad: $result --> $value");
//   },
// ),