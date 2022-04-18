import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/controllers/stockdetails_controller.dart';
import 'package:stock_market_app/app/utils/AdManager.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/no_data_found.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/constants/string_constant.dart';
import '../../home/maindata_responce.dart';

class ChartView extends StatefulWidget {
  final String? argument;
  final String? price;
  final ResultData? resultData;

  const ChartView({Key? key, this.argument, this.price,this.resultData}) : super(key: key);

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  StockdetailsController _stockdetailsController = Get.put(StockdetailsController());
  List<String> dayType = [
    "1d",
    "5d",
    "1mo",
    "6mo",
    "1y",
    "5y",
    "max",
  ];

  List<String> intevalType = [
    "1m",
    "15m",
    "15m",
    "1d",
    "1d",
    "1mo",
    "1mo",
  ];

  late Timer _timer;
  int _start = 15;
  int selectedIndex = 0;
  late TrackballBehavior _trackballBehavior;
  String currentFilter="1d";

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _stockdetailsController.callGetSummaryData(widget.argument!);
      _stockdetailsController.callGetChartData(dayType[0], widget.argument!,intevalType[0]);
    });
    _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
    startTimer();
    bannerSize = AdmobBannerSize.BANNER;
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


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.reactive;
          _start=15;
        });
        _stockdetailsController.callGetSummaryData(widget.argument!);
      } else {
        setState(() {
          _start--;
        });
      }
    },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx((){
          return Stack(
            children: [
              Column(
                children: [
                  _Headerview(),
                  _chart(),
                  _monthView(),
                  AdManager.getBannerAdUnitId()!=""?Container(
                    height: 7.5.h,
                    child: Align(
                      alignment: Alignment(0, 1.0),
                      child: AdmobBanner(
                        adUnitId: AdManager.getBannerAdUnitId()!,
                        adSize: bannerSize!,
                        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                          handleEvent(event, args, 'Banner');
                        },
                        onBannerCreated:(AdmobBannerController controller) {},
                      ),
                    ),
                  ):SizedBox.shrink(),
                ],
              ),
              _stockdetailsController.isLoading.value==true?Center(child: CircularProgressIndicator(color: Colors.white)):SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }

  Widget _Headerview() {
    return Obx((){
      if(_stockdetailsController.summaryResult.length>0){
        String fullname = _stockdetailsController.summaryResult[0].price!.longName!;
        if(fullname==null || fullname=="null" || fullname==""){
          fullname = _stockdetailsController.summaryResult[0].price!.shortName!;
        }
        String currencySymbol = _stockdetailsController.summaryResult[0].price!.currencySymbol.toString();
        String price = "";
        if(currencySymbol!="" || currencySymbol!="null"){
          price=currencySymbol+_stockdetailsController.summaryResult[0].price!.regularMarketPrice!.fmt.toString();
        }else{
          price="\$"+_stockdetailsController.summaryResult[0].price!.regularMarketPrice!.fmt.toString();
        }
        String priceChange =_stockdetailsController.summaryResult[0].price!.regularMarketChange!.fmt.toString();
        String pricePer = _stockdetailsController.summaryResult[0].price!.regularMarketChangePercent!.fmt.toString();

        int flag=0;
        if(priceChange.contains("-")){
          flag=1;
        }
        int flagP=0;
        if(pricePer.contains("-")){
          flagP=1;
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
          decoration: BoxDecoration(
              color: primaryCl
          ),
          child: Row(
            children: [
              Expanded(child: Text(fullname!="null"?fullname:"",style: Theme.of(context).textTheme.headline2,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 0.5.h,left: 2.w,right: 1.w,bottom: 0.5.h),
                    child: Text(price,maxLines: 1, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 0.5.h,right: 2.w),
                    child: Row(
                      children: [
                        Text(priceChange,maxLines: 1,style: Theme.of(context).textTheme.headline5!.copyWith(color: flag==0?Colors.green:Colors.red,fontWeight: FontWeight.bold)),
                        SizedBox(width: 1.w,),
                        Text("("+pricePer+")",maxLines: 1,style: Theme.of(context).textTheme.headline5!.copyWith(color: flagP==0?Colors.green:Colors.red,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }else{
        return Container();
      }
    });
  }

  Widget _chart() {
    return Expanded(
      child: Obx(() {
          return _stockdetailsController.candlesData.length>3?InteractiveChart(
                  candles: _stockdetailsController.candlesData,
                ):_stockdetailsController.isLoading==true?SizedBox.shrink():NoDataFound();
      }),
    );
  }

  Widget _monthView() {
    return Container(
      height: 8.h,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 0.h, left: 5.w,right: 5.w),
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
          itemCount: dayType.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (contex, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.0.h),
              height: 5.w,
              width: 11.w,
              child: InkWell(
                onTap: () async{
                  DStr.currenCountCount=DStr.currenCountCount+1;
                  if(DStr.clickCount==DStr.currenCountCount){
                    DStr.currenCountCount=0;
                    showAds();
                  }
                  callChartApi(index);
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  height: 5.w,
                  width: 11.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? secondaryCl : fontDarkCl.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Text(
                    dayType[index],
                    style: Theme.of(contex).textTheme.headline4!.copyWith(color: selectedIndex == index ? Colors.white : Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void callChartApi(int index) {
      String inteval=intevalType[index];
      String filterValue=dayType[index];
    _stockdetailsController.callGetChartData(filterValue, widget.argument!,inteval);
  }

}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  DateTime? x;
  num? open;
  num? close;
  num? low;
  num? high;
}
