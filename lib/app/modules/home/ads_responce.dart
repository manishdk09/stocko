// To parse this JSON data, do
//
//     final adsResponce = adsResponceFromJson(jsonString);

import 'dart:convert';

AdsResponce adsResponceFromJson(String str) => AdsResponce.fromJson(json.decode(str));

String adsResponceToJson(AdsResponce data) => json.encode(data.toJson());

class AdsResponce {
  AdsResponce({
    this.googleAds,
    this.qurekaAds,
    this.clickCount,
  });

  GoogleAds? googleAds;
  QurekaAds? qurekaAds;
  int? clickCount;

  factory AdsResponce.fromJson(Map<String, dynamic> json) => AdsResponce(
    googleAds: GoogleAds.fromJson(json["google_ads"]),
    qurekaAds: QurekaAds.fromJson(json["qureka_ads"]),
    clickCount: json["click_count"],
  );

  Map<String, dynamic> toJson() => {
    "google_ads": googleAds!.toJson(),
    "qureka_ads": qurekaAds!.toJson(),
    "click_count": clickCount,
  };
}

class GoogleAds {
  GoogleAds({
    this.interstitial,
    this.native,
    this.nativeBanner,
    this.openApp,
  });

  List<String>? interstitial;
  List<String>? native;
  List<String>? nativeBanner;
  List<String>? openApp;

  factory GoogleAds.fromJson(Map<String, dynamic> json) => GoogleAds(
    interstitial: List<String>.from(json["interstitial"].map((x) => x)),
    native: List<String>.from(json["native"].map((x) => x)),
    nativeBanner: List<String>.from(json["native_banner"].map((x) => x)),
    openApp: List<String>.from(json["open_app"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "interstitial": List<dynamic>.from(interstitial!.map((x) => x)),
    "native": List<dynamic>.from(native!.map((x) => x)),
    "native_banner": List<dynamic>.from(nativeBanner!.map((x) => x)),
    "open_app": List<dynamic>.from(openApp!.map((x) => x)),
  };
}

class QurekaAds {
  QurekaAds({
    this.adLink,
    this.adsImages,
  });

  String? adLink;
  AdsImages? adsImages;

  factory QurekaAds.fromJson(Map<String, dynamic> json) => QurekaAds(
    adLink: json["ad_link"],
    adsImages: AdsImages.fromJson(json["ads_images"]),
  );

  Map<String, dynamic> toJson() => {
    "ad_link": adLink,
    "ads_images": adsImages!.toJson(),
  };
}

class AdsImages {
  AdsImages({
    this.banner1,
    this.banner2,
    this.banner3,
    this.banner4,
    this.header1,
    this.header2,
    this.header3,
    this.header4,
    this.native1,
    this.native2,
    this.native3,
    this.native4,
    this.native5,
    this.native6,
    this.interstitial1,
    this.interstitial2,
    this.interstitial3,
    this.interstitial4,
  });

  String? banner1;
  String? banner2;
  String? banner3;
  String? banner4;
  String? header1;
  String? header2;
  String? header3;
  String? header4;
  String? native1;
  String? native2;
  String? native3;
  String? native4;
  String? native5;
  String? native6;
  String? interstitial1;
  String? interstitial2;
  String? interstitial3;
  String? interstitial4;

  factory AdsImages.fromJson(Map<String, dynamic> json) => AdsImages(
    banner1: json["banner_1"],
    banner2: json["banner_2"],
    banner3: json["banner_3"],
    banner4: json["banner_4"],
    header1: json["header_1"],
    header2: json["header_2"],
    header3: json["header_3"],
    header4: json["header_4"],
    native1: json["native_1"],
    native2: json["native_2"],
    native3: json["native_3"],
    native4: json["native_4"],
    native5: json["native_5"],
    native6: json["native_6"],
    interstitial1: json["interstitial_1"],
    interstitial2: json["interstitial_2"],
    interstitial3: json["interstitial_3"],
    interstitial4: json["interstitial_4"],
  );

  Map<String, dynamic> toJson() => {
    "banner_1": banner1,
    "banner_2": banner2,
    "banner_3": banner3,
    "banner_4": banner4,
    "header_1": header1,
    "header_2": header2,
    "header_3": header3,
    "header_4": header4,
    "native_1": native1,
    "native_2": native2,
    "native_3": native3,
    "native_4": native4,
    "native_5": native5,
    "native_6": native6,
    "interstitial_1": interstitial1,
    "interstitial_2": interstitial2,
    "interstitial_3": interstitial3,
    "interstitial_4": interstitial4,
  };
}
