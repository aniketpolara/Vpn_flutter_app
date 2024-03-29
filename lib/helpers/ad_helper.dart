import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';
import 'config.dart';
import 'my_dialogs.dart';

class AdHelper {
  // for initializing ads sdk
  static Future<void> initAds() async {
    await MobileAds.instance.initialize();
  }

  static void showInterstitialAd({required VoidCallback onComplete}) {
    MyDialogs.showProgress();

    log('Interstitial Ad Id: ${Config.interstitialAd}');

    InterstitialAd.load(
      adUnitId: Config.interstitialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            onComplete();
          });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  static NativeAd loadNativeAd({required NativeAdController adController}) {
    log('Native Ad Id: ${Config.nativeAd}');

    return NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/1044960115",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            log('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void showRewardedAd({required VoidCallback onComplete}) {
    log('Rewarded Ad Id: ${Config.rewardedAd}');

    MyDialogs.showProgress();

    RewardedAd.load(
      adUnitId: Config.rewardedAd,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          Get.back();

          //reward listener
          ad.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            onComplete();
          });
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          // onComplete();
        },
      ),
    );
  }
}
