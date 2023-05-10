import 'package:complaint_portal/common/services/ads/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  InterstitialAd? _interstitialAd;
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('InterstitialAd loaded.');
          _interstitialAd = ad;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  AppOpenAd? _appOpenAd;
  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.openAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          debugPrint('AppOpenAd loaded.');
          _appOpenAd = ad;
          _showAppOpenAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  void _showAppOpenAd() {
    if (_appOpenAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (AppOpenAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (AppOpenAd ad, AdError error) {
        ad.dispose();
      },
    );
    _appOpenAd!.show();
    _appOpenAd = null;
  }
}
