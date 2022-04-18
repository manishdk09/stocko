import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/stockdetails_view.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/no_data_found.dart';

import '../../../utils/AdManager.dart';
import '../../../utils/constants/string_constant.dart';
import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var _searchController = TextEditingController();
  SearchController _searchDataController = Get.put(SearchController());
  bool isSearch = false;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      String searchText = _searchController.text.toLowerCase();
      if (searchText.length > 0) {
        setState(() {
          isSearch = true;
        });
        _searchDataController.callSearchApi(searchText);
      } else {
        setState(() {
          isSearch = false;
        });
      }
    });
    interstitialAd = AdmobInterstitial(
      adUnitId: AdManager.getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
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
                    DStr.search,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text(
                    "Search Companies",
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
        body: Builder(
            builder: (context) => Container(
                  margin: EdgeInsets.only(top: 2.h),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.w),
                        child: TextFormField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            cursorColor: Colors.white60,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              fillColor: fontDarkCl.withOpacity(0.6),
                              filled: true,
                              counterText: "",
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                              hintText: "Search",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(5.sp)),
                                  borderSide: new BorderSide(
                                      width: 0.5,
                                      style: BorderStyle.solid,
                                      color: primaryCl
                                          .withOpacity(0.5)
                                          .withOpacity(0.5))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(5.sp)),
                                  borderSide: new BorderSide(
                                      width: 0.5,
                                      style: BorderStyle.solid,
                                      color: primaryCl
                                          .withOpacity(0.5)
                                          .withOpacity(0.5))),
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: double.infinity,
                            child: isSearch
                                ? _searchDataController.resultData.length>0?ListView.builder(
                                itemCount: _searchDataController.resultData.length,
                                itemBuilder: (contex, index) {
                                  String symbol=_searchDataController.resultData[index].symbol!;
                                  String shortname=_searchDataController.resultData[index].shortName!.toString();
                                  String exchange=_searchDataController.resultData[index].exchange!;
                                  String market=_searchDataController.resultData[index].market!;
                                  String price=market=="in_market"?"\u20B9"+ _searchDataController.resultData[index].regularMarketPrice!.fmt!:"\$" + _searchDataController.resultData[index].regularMarketPrice!.fmt!;
                                  String changeValue=_searchDataController.resultData[index].regularMarketChange!.raw!.toPrecision(2).toString();
                                  String percentage=_searchDataController.resultData[index].regularMarketChangePercent!.fmt!;
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
                                      Get.to(StockdetailsView(argument: symbol, resultData:_searchDataController.resultData[index],));
                                    },
                                    child: Container(
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
                                }):NoDataFound()
                                :  SearchData()),
                      )
                    ],
                  ),
                )));
  }


}
