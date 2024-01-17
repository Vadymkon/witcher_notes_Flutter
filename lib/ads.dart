import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter/material.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-5539034933682073/7156870758';
    else if (Platform.isIOS) return 'ca-app-pub-5539034933682073/2074002839';
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded.'),
    onAdFailedToLoad: (ad,error) {
      ad.dispose();
      debugPrint('Ad failed with error: $error.');
    },
    onAdOpened: (ad) => debugPrint('Ad opened.'),
    onAdClosed: (ad) => debugPrint('Ad closed.'),
  );

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-5539034933682073/3766358451';
    else if (Platform.isIOS) return 'ca-app-pub-5539034933682073/1048178852';
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-5539034933682073/1931366752';
    else if (Platform.isIOS) return 'ca-app-pub-5539034933682073/1324027942';
    return null;
  }
  //
  // static final BannerAdListener bannerAdListener = BannerAdListener(
  //   onAdLoaded: (ad) => debugPrint('Ad loaded.'),
  //   onAdFailedToLoad: (ad,error) {
  //     ad.dispose();
  //     debugPrint('Ad failed with error: $error.');
  //   },
  //   onAdOpened: (ad) => debugPrint('Ad opened.'),
  //   onAdClosed: (ad) => debugPrint('Ad closed.'),
  // );

}