import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/AdManager.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {


  late AdmobInterstitial interstitialAd;

  @override
  void dispose() {
    interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdManager.getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: AppBar(
            toolbarHeight: 7.5.h,
            title:Container(
              padding: EdgeInsets.only(top: 1.5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DStr.setting,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text(
                    "App settings",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w500,color: fontDarkCl),
                  ),
                ],
              ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: primaryCl,
          ),
        ),
        body: Builder(builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h,),
                    _settingMenu(context,"Share"),
                    Divider(color: Colors.grey.shade500,),
                    _settingMenu(context,"Other Apps"),
                    Divider(color: Colors.grey.shade500,),
                    InkWell(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: "stockomaster@gmail.com"));
                        final snackBar = SnackBar(
                          content: const Text('Email-Id Copy!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 6.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact Us",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              "stockomaster@gmail.com",
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey.shade500,),
                    _settingMenu(context,"Rate Us"),
                    Divider(color: Colors.grey.shade500,),
                  ],
                )),
        bottomNavigationBar: AdManager.getBannerAdUnitId()!=""?Container(
          height: 35.5.h,
          child: Align(
            alignment: Alignment.center,
            child: AdmobBanner(
              adUnitId:AdManager.getBannerAdUnitId()!,
              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
              listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                handleEvent(event, args, 'Banner');
              },
              onBannerCreated: (AdmobBannerController controller) {},
            ),
          ),
        ):SizedBox.shrink(),
    );

  }

  _settingMenu(BuildContext context,String title) {
    return InkWell(
      onTap: (){
        DStr.currenCountCount=DStr.currenCountCount+1;
        if(DStr.clickCount==DStr.currenCountCount){
          DStr.currenCountCount=0;
          showAds();
        }
        switch(title){
          case "Share":
            shareApp();
            break;
          case "Other Apps":
            _launchURL();
            break;
          case "Rate Us":
            _launchURL();
            break;
        }
      },
      child: Container(
        width: double.infinity,
        height: 6.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  void _launchURL() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String _url =
        "https://play.google.com/store/apps/details?id=" + packageName;
    if (!await launch(_url)) throw 'Could not launch $_url';
  }


  Future<void> shareApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String _url = "https://play.google.com/store/apps/details?id=" + packageName;
    await FlutterShare.share(
        title: 'Share Application',
        text: 'Share Application',
        linkUrl: _url,
        chooserTitle: 'Share Application'
    );
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void handleEvent(AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        interstitialAd.load();
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        interstitialAd.load();
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }

  void showAds() async {
    print("Show Ads......");
    final isLoaded = await interstitialAd.isLoaded;
    if (isLoaded ?? false) {
      interstitialAd.show();
    } else {
      print('Interstitial ad is still loading...');
    }
  }

}
