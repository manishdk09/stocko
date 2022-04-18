import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/home/controllers/home_controller.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/no_data_found.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/AdManager.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/string_constant.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  HomeController _homeController = Get.put(HomeController());
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    // api call get news
    _homeController.getNews();

    // initalise and load intertial Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: AdManager.getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  // handel ads events
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

  // show ads
  void showAds() async {
    print("Show Ads......");
    final isLoaded = await interstitialAd.isLoaded;
    if (isLoaded ?? false) {
      interstitialAd.show();
    } else {
      print('Interstitial ad is still loading...');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AppBar(
          toolbarHeight: 7.5.h,
          title: Container(
            padding: EdgeInsets.only(top: 1.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DStr.news,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  "Trending News",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500, color: fontDarkCl),
                ),
              ],
            ),
          ),
          centerTitle: false,
          backgroundColor: primaryCl,
          elevation: 0,
        ),
      ),
      body: Obx(() {
        if (_homeController.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else
          return _newsList();
      }),
    );
  }

  // news list
  Widget _newsList() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: _homeController.stocksNews.length > 0
          ? RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  itemCount: _homeController.stocksNews.length,
                  itemBuilder: (contex, index) {
                    String Ads=DStr.banner_1;

                    String title = _homeController.stocksNews[index].title!;
                    String description =
                        _homeController.stocksNews[index].description!;
                    String url = _homeController.stocksNews[index].url!;
                    List<String> tickers = _homeController
                        .stocksNews[index].tickers!
                        .split(",")
                        .toList();
                    String source = _homeController.stocksNews[index].source!;
                    String publishedDate = _homeController.stocksNews[index].publishedDate!;
                    String img = _homeController.stocksNews[index].img_url!;
                    return index % 2 == 0 && index != 0
                        ? Column(
                            children: [
                              index > 3
                                  ?InkWell(
                                      onTap: () {
                                        _launchInBrowser(DStr.clickLink);
                                      },
                                      child:AdManager.getQurekaNativeId()!=""?Container(
                                        height: 33.h,
                                        child: Image.network(
                                          AdManager.getQurekaNativeId()??"",
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      ):SizedBox.shrink(),
                                    )
                                  : AdManager.getBannerAdUnitId()!=""?Container(
                                      height: 35.h,
                                      child: Align(
                                        alignment: Alignment(0, 1.0),
                                        child: AdmobBanner(
                                          adUnitId:
                                              AdManager.getBannerAdUnitId()!,
                                          adSize:
                                              AdmobBannerSize.MEDIUM_RECTANGLE,
                                          listener: (AdmobAdEvent event,
                                              Map<String, dynamic>? args) {
                                            handleEvent(event, args, 'Banner');
                                          },
                                          onBannerCreated:
                                              (AdmobBannerController
                                                  controller) {},
                                        ),
                                      ),
                                    ): InkWell(
                                onTap: () {
                                  _launchInBrowser(DStr.clickLink);
                                },
                                child:AdManager.getQurekaNativeId()!=""? Container(
                                  height: 33.h,
                                  child: Image.network(
                                    AdManager.getQurekaNativeId()??"",
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ):SizedBox.shrink(),
                              ),
                              InkWell(
                                onTap: () {
                                  DStr.currenCountCount =
                                      DStr.currenCountCount + 1;
                                  if (DStr.clickCount ==
                                      DStr.currenCountCount) {
                                    DStr.currenCountCount = 0;
                                    showAds();
                                  }
                                  _launchInBrowser(url);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5.0),
                                  child: Card(
                                    elevation: 2,
                                    color: fontDarkCl.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.sp)),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(bottom: 1.5.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              img != null && img != ""
                                                  ? Container(
                                                      child: Image.network(img,
                                                          height: 20.h,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover),
                                                    )
                                                  : SizedBox.shrink(),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w),
                                                child: Wrap(
                                                  children: [
                                                    Text(
                                                      title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w),
                                                child: Text(
                                                  "${timeago.format(DateTime.parse(publishedDate).toLocal())}",
                                                  // publishedDate,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: fontDarkCl),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.8.h,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w),
                                                child: Wrap(
                                                  children: [
                                                    Text(
                                                      description,
                                                      maxLines: 3,
                                                      softWrap: true,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color:
                                                                  fontDarkCl),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: tickers.length > 0
                                                          ? Wrap(
                                                              children: tickers
                                                                  .take(4)
                                                                  .map((e) =>
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                3.0,
                                                                            vertical:
                                                                                2.0),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                8.0,
                                                                            vertical:
                                                                                4.0),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                fontDarkCl.withOpacity(0.5),
                                                                            borderRadius: BorderRadius.circular(3.0)),
                                                                        child:
                                                                            Text(
                                                                          e.toUpperCase(),
                                                                          maxLines:
                                                                              1,
                                                                          softWrap:
                                                                              true,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline5!
                                                                              .copyWith(color: Colors.white),
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                            )
                                                          : SizedBox.shrink(),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _launchInBrowser(
                                                                url),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Read More..",
                                                            maxLines: 1,
                                                            softWrap: true,
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color:
                                                                        fontDarkCl),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              DStr.currenCountCount = DStr.currenCountCount + 1;
                              if (DStr.clickCount == DStr.currenCountCount) {
                                DStr.currenCountCount = 0;
                                showAds();
                              }
                              _launchInBrowser(url);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 5.0),
                              child: Card(
                                elevation: 2,
                                color: fontDarkCl.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp)),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 1.5.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          img != null && img != ""
                                              ? Container(
                                                  child: Image.network(img,
                                                      height: 20.h,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Text(
                                              "${timeago.format(DateTime.parse(publishedDate).toLocal())}",
                                              // publishedDate,
                                              maxLines: 1,
                                              softWrap: true,
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: fontDarkCl),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  description,
                                                  maxLines: 3,
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: fontDarkCl),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: tickers.length > 0
                                                      ? Wrap(
                                                          children: tickers
                                                              .take(4)
                                                              .map(
                                                                  (e) =>
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                3.0,
                                                                            vertical:
                                                                                2.0),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                8.0,
                                                                            vertical:
                                                                                4.0),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                fontDarkCl.withOpacity(0.5),
                                                                            borderRadius: BorderRadius.circular(3.0)),
                                                                        child:
                                                                            Text(
                                                                          e.toUpperCase(),
                                                                          maxLines:
                                                                              1,
                                                                          softWrap:
                                                                              true,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline5!
                                                                              .copyWith(color: Colors.white),
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                        )
                                                      : SizedBox.shrink(),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _launchInBrowser(url),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Read More..",
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color:
                                                                    fontDarkCl),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  }),
            )
          : NoDataFound(msg: "No any news available!", icon: DImg.newspaper),
    );
  }

  // open qureka Ads link
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    )) {
      throw 'Could not launch $url';
    }
  }

  // pull to refresh call api for refresh data
  Future<void> _pullRefresh() async {
    await _homeController.getSymbolRefresh();
  }
}
