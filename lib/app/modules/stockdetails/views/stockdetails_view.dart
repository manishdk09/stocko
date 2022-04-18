import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/news_view.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/statistics_view.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/summary_view.dart';
import 'package:stock_market_app/app/utils/AdManager.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';

import '../../home/controllers/home_controller.dart';
import '../../home/maindata_responce.dart';
import 'chart_view.dart';

class StockdetailsView extends StatefulWidget {
  final String? argument;
  final String? price;
  final ResultData? resultData;

  const StockdetailsView({Key? key, this.argument, this.price, this.resultData})
      : super(key: key);

  @override
  State<StockdetailsView> createState() => _StockdetailsViewState();
}

class _StockdetailsViewState extends State<StockdetailsView>
    with SingleTickerProviderStateMixin {
  HomeController _homeController = Get.put(HomeController());
  List<dynamic> favoriteData = [];
  bool isFavorite = false;
  late GetStorage storage;
  int _selectedIndex = 0;
  String favoriteSymbol = "";

  late AdmobInterstitial interstitialAd;
  late TabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(() {
      DStr.currenCountCount = DStr.currenCountCount + 1;
      if (DStr.clickCount == DStr.currenCountCount) {
        DStr.currenCountCount = 0;
        showAds();
      }
    });
    storage = new GetStorage();
    if (storage.hasData(DStr.FAVORITE)) {
      favoriteData = storage.read(DStr.FAVORITE);
      if (favoriteData != null) {
        if (favoriteData.contains(widget.argument)) {
          isFavorite = true;
        }
        setState(() {});
      }
    }
    interstitialAd = AdmobInterstitial(
      adUnitId: AdManager.getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
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

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.argument!,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        backgroundColor: secondaryCl,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: InkWell(
            onTap: () {
              DStr.currenCountCount = DStr.currenCountCount + 1;
              if (DStr.clickCount == DStr.currenCountCount) {
                DStr.currenCountCount = 0;
                showAds();
              }
              Get.back();
            },
            child: Icon(
              Icons.keyboard_backspace,
              size: 25.sp,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () => _favoriteAction(),
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border_sharp,
                color: isFavorite ? Colors.amberAccent : Colors.white,
                size: 20.sp,
              )),
          SizedBox(
            width: 1.w,
          )
        ],
        bottom: TabBar(
          labelStyle: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.bold),
          isScrollable: true,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.white,
         controller: _controller,
          tabs: [
            Tab(text: "Profile"),
            Tab(text: "Information"),
            Tab(text: "Statistics"),
            Tab(text: "Insights"),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          ChartView(argument: widget.argument, resultData: widget.resultData),
          SummaryView(argument: widget.argument, resultData: widget.resultData),
          StatisticsView(argument: widget.argument, resultData: widget.resultData),
          NewsView(argument: widget.argument, resultData: widget.resultData),
        ],
      ),
    );
  }

  /**
   * Make Stock favorite and unfavorite.
   */
  _favoriteAction() {
    DStr.currenCountCount = DStr.currenCountCount + 1;
    if (DStr.clickCount == DStr.currenCountCount) {
      DStr.currenCountCount = 0;
      showAds();
    }
    if (favoriteData.contains(widget.argument)) {
      favoriteData.remove(widget.argument);
      if (favoriteData.isNotEmpty) {
        String favoriteSymbol = favoriteData.join(",");
        Future.delayed(Duration.zero, () {
          _homeController.getMainDataFavo(favoriteSymbol);
        });
      } else {
        _homeController.resultDataFavo.clear();
      }
      isFavorite = false;
    } else {
      favoriteData.add(widget.argument!);
      String favoriteSymbol = favoriteData.join(",");
      Future.delayed(Duration.zero, () {
        _homeController.getMainDataFavo(favoriteSymbol);
      });
      isFavorite = true;
    }
    storage.write(DStr.FAVORITE, favoriteData);
    setState(() {});
  }

}
