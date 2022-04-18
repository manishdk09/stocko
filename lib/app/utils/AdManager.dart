import 'dart:math';

import 'constants/string_constant.dart';

class AdManager{

  static String? getInterstitialAdUnitId() {
    var rng = Random();
    rng.nextInt(100);
    if (rng.nextInt(10)>5) {
      return DStr.G_INTERSTITIAL;
    }else{
      return DStr.G_INTERSTITIAL2;
    }
  }

  static String? getBannerAdUnitId() {
    var rng = Random();
    rng.nextInt(100);
    if (rng.nextInt(10)>5) {
      return DStr.gg_nat_bnr;
    }else{
      return DStr.gg_nat_bnr2;
    }
  }

  static String? getQurekaBannerId() {
    var rng = Random();
    int x=rng.nextInt(100);
    if (x>75) {
      return DStr.banner_4;
    }else if (x<75 && x>50){
      return DStr.banner_2;
    }else if(x<50 && x>25){
      return DStr.banner_3;
    }else{
      return DStr.banner_1;
    }
  }

  static String? getQurekaNativeId() {
    var rng = Random();
    int x=rng.nextInt(100);
    if (x>90) {
      return DStr.native_6;
    }else if (x<90 && x>70){
      return DStr.native_5;
    }else if(x<70 && x>55){
      return DStr.native_4;
    }else if(x<55 && x>40){
      return DStr.native_3;
    }else if(x<40 && x>20){
      return DStr.native_2;
    }else{
      return DStr.native_1;
    }
  }


// static String? getInterstitialAdUnitId() {
  //   String adString=DStr.gg_nat_bnr;
  //
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/1033173712';
  //   }
  //   return null;
  // }


}