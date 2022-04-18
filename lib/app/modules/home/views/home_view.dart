import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/stockdetails_view.dart';
import 'package:stock_market_app/app/utils/AdManager.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/constants/image_constant.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/no_data_found.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  HomeController _homeController = Get.put(HomeController());
  String currentData="";
  List<dynamic> favoriteData=[];
  late GetStorage storage;
  late AdmobInterstitial interstitialAd;


  @override
  void initState() {
    super.initState();
    // call api
    DateTime now = DateTime.now();
    currentData = DateFormat('MMMM d').format(now);
    _homeController.getSymbol();

    // get favorite item and make list from local storage
    storage=new GetStorage();
    if(storage.hasData(DStr.FAVORITE)){
      favoriteData=storage.read(DStr.FAVORITE);
      print(favoriteData);
      if(favoriteData.length>0){
        var stringList = favoriteData.join(",");
        Future.delayed(Duration.zero,(){
          _homeController.getMainDataFavo(stringList);
        });
      }
    }

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
                  DStr.portfolio,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
                SizedBox(height: 0.5.h,),
                Text(
                  currentData,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500,color: fontDarkCl),
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
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        } else
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                SizedBox(height: 1.h,),
                _titleView("Trending Stocks"),
                _listViewHorizontal(),
                _titleView("Favorite Stocks"),
                _listView(),
              ],
            ),
          );
      }),
    );
  }

  // Title of list view
  Widget _titleView(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
      child: Text(title,style: Theme.of(context).textTheme.headline3!.copyWith(color: secondaryCl,fontWeight: FontWeight.w700),),
    );
  }

  // Horizontal list View
  Widget _listViewHorizontal() {
    return Container(
        height: 12.h,
        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
        child:_homeController.resultData.length > 0? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _homeController.resultData.length,
            itemBuilder: (contex, index) {
              String name = _homeController.resultData[index].symbol.toString();
              String subname = _homeController.resultData[index].longName.toString();
              String market = _homeController.resultData[index].market.toString();
              String price=market=="in_market"?"\u20B9"+_homeController.resultData[index].regularMarketPrice!.fmt!:"\$"+ _homeController.resultData[index].regularMarketPrice!.fmt!;
              String priceChange = _homeController.resultData[index].regularMarketChange!.raw!.toPrecision(2).toString();
              int flag=0;
              if(priceChange.contains("-")){
                flag=1;
              }
              return InkWell(
                onTap: () {
                  DStr.currenCountCount=DStr.currenCountCount+1;
                  if(DStr.clickCount==DStr.currenCountCount){
                    DStr.currenCountCount=0;
                    showAds();
                  }
                  Get.to(StockdetailsView(argument: name,resultData:_homeController.resultData[index]));
                },
                child: Card(
                  color: fontDarkCl.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Container(
                      width: 30.w,
                      height: 10.h,
                      child: Container(
                        decoration: BoxDecoration(
                            color: fontDarkCl.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 1.h,left: 2.w),
                                    child: Text(name,maxLines: 1,style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 0.5.h,right: 2.w),
                                    child: Text(priceChange,maxLines: 1,style: Theme.of(context).textTheme.headline6!.copyWith(color: flag==0?Colors.green:Colors.red,fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 0.5.h,left: 2.w,right: 2.w),
                                child: Text(subname,maxLines: 2,overflow: TextOverflow.visible, style: Theme.of(context).textTheme.headline6!.copyWith(color: fontDarkCl,fontSize: 9.sp),),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 1.h,left: 2.w,right: 1.w),
                                child: Text(price,maxLines: 1, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              );
            }):SizedBox.shrink());
  }

  // Favorite item list View
  Widget _listView() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
            child:_homeController.resultDataFavo.length>0?ListView.builder(
            itemCount: _homeController.resultDataFavo.length,
            itemBuilder: (contex, index) {
                String symbol=_homeController.resultDataFavo[index].symbol!;
                String shortname=_homeController.resultDataFavo[index].shortName!;
                String exchange=_homeController.resultDataFavo[index].exchange!;
                String market=_homeController.resultDataFavo[index].market!;
                String price=market=="in_market"?"\u20B9"+ _homeController.resultDataFavo[index].regularMarketPrice!.fmt!:"\$"+ _homeController.resultDataFavo[index].regularMarketPrice!.fmt!;
                String changeValue=_homeController.resultDataFavo[index].regularMarketChange!.raw!.toPrecision(2).toString();
                String percentage=_homeController.resultDataFavo[index].regularMarketChangePercent!.fmt!;
                int flag=0;
                if(changeValue.contains("-")){
                  flag=1;
                }
                return InkWell(
                  onTap: () {
                    DStr.currenCountCount=DStr.currenCountCount+1;
                    if(DStr.clickCount==DStr.currenCountCount){
                      DStr.currenCountCount=0;
                      showAds();
                    }
                    Get.to(StockdetailsView(argument: symbol, resultData:_homeController.resultDataFavo[index],));
                  },
                  child: index%3==0 && index!=0?Column(
                    children: [
                      index>5?InkWell(
                        onTap: () {
                          _launchInBrowser(DStr.clickLink);
                        },
                        child:AdManager.getQurekaBannerId()!=""? Container(
                          height: 10.h,
                          child: Image.network(
                            AdManager.getQurekaBannerId()??"",
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ):SizedBox.shrink(),
                      ):AdManager.getBannerAdUnitId()!=""?AdmobBanner(
                        adUnitId: AdManager.getBannerAdUnitId()!,
                        adSize: AdmobBannerSize.BANNER,
                        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                          handleEvent(event, args, 'Banner');
                        },
                        onBannerCreated: (AdmobBannerController controller) {},
                      ):AdManager.getQurekaBannerId()!=""?InkWell(
                        onTap: () {
                          _launchInBrowser(DStr.clickLink);
                        },
                        child: Container(
                          height: 10.h,
                          child: Image.network(
                            AdManager.getQurekaBannerId()??"",
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ):SizedBox.shrink(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0.5.h),
                        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                        decoration: BoxDecoration(
                            color: fontDarkCl.withOpacity(0.2),borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.bottomCenter,
                                                child: Text(
                                                  symbol,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(width: 1.w,),
                                              Container(
                                                alignment: Alignment.bottomCenter,
                                                child: Text(
                                                  "("+exchange+")",
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                      color: Colors.white60),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              shortname,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                  color: Colors.white60),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          price.toString(),
                                          style: Theme.of(
                                              context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                              fontWeight:
                                              FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h,),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            Text(
                                              changeValue.toString(),
                                              style: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,color: flag==0?Colors.green:Colors.red),
                                            ),
                                            SizedBox(width: 1.w,),
                                            Text(
                                              "("+percentage.toString()+")",
                                              style: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,color: flag==0?Colors.green:Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ):Container(
                    margin: EdgeInsets.symmetric(vertical: 0.5.h),
                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                    decoration: BoxDecoration(
                        color: fontDarkCl.withOpacity(0.2),borderRadius: BorderRadius.circular(5.sp)
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              symbol,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight.w800),
                                            ),
                                          ),
                                          SizedBox(width: 1.w,),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              "("+exchange+")",
                                              maxLines: 1,
                                              softWrap: true,
                                              style: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                  color: Colors.white60),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          shortname,
                                          maxLines: 1,
                                          softWrap: true,
                                          style: Theme.of(
                                              context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                              color: Colors.white60),
                                        ),
                                      ),
                                    ],
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      price.toString(),
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                          fontWeight:
                                          FontWeight.w800),
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h,),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Text(
                                          changeValue.toString(),
                                          style: Theme.of(
                                              context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,color: flag==0?Colors.green:Colors.red),
                                        ),
                                        SizedBox(width: 1.w,),
                                        Text(
                                          "("+percentage.toString()+")",
                                          style: Theme.of(
                                              context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,color: flag==0?Colors.green:Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              // }
            }):NoDataFound(msg: "No any favorites",icon: DImg.analysis),
        ),
      ),
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
