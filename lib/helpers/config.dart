import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  static final _config = FirebaseRemoteConfig.instance;

  static const _defaultValues = {
    "ad_type": "facebook",

    //facebook
    "facebook_int": "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617e",
    "facebook_banner":
        "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047e",
    "facebook_main_id": "3b656c58-53ab-43a8-a0d6-d1f82abdf251",
    "facebook_native": "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",

    //admob
    "interstitial_ad": "ca-app-pub-3940256099942544/1033173712",
    "native_ad": "ca-app-pub-3940256099942544/2247696110",
    "rewarded_ad": "ca-app-pub-3940256099942544/5224354917",
    "show_ads": true
  };

  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 30)));

    await _config.setDefaults(_defaultValues);
    await _config.fetchAndActivate();
    log('Remote Config Data: ${_config.getBool('show_ads')}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();
      log('Updated: ${_config.getBool('show_ads')}');
    });
  }

  static bool get showAd => _config.getBool('show_ads');
  //ad type
  static String get adtype => _config.getString('ad_type');

  //ad ids
  static String get nativeAd => _config.getString('native_ad');
  static String get interstitialAd => _config.getString('interstitial_ad');
  static String get rewardedAd => _config.getString('rewarded_ad');
  //facebook
  static String get fbnative => _config.getString('facebook_native');
  static String get fbbanner => _config.getString('facebook_banner');
  static String get fbint => _config.getString('facebook_int');
  static String get fbmain => _config.getString('facebook_main_id');
}
