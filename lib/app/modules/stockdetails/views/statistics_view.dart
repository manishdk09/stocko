import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/controllers/stockdetails_controller.dart';
import 'package:stock_market_app/app/modules/stockdetails/summary_data_model.dart';
import 'package:stock_market_app/app/utils/no_data_found.dart';

import '../../../utils/AdManager.dart';
import '../../../utils/constants/color_constant.dart';
import '../../home/maindata_responce.dart';

class StatisticsView extends StatefulWidget {
  final String? argument;
  final ResultData? resultData;
  const StatisticsView({Key? key, this.argument,this.resultData}) : super(key: key);

  @override
  State<StatisticsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<StatisticsView> {

  StockdetailsController _stockdetailsController = Get.put(StockdetailsController());

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _stockdetailsController.callGetSummaryData(widget.argument!);
    });
    // _showNativeBannerAd();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Center(
        child: _stockdetailsController.isLoading.value
            ? CircularProgressIndicator()
            : Container(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stockdetailsController.summaryResult.length > 0?SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 0.w),
                    child: _itemView(_stockdetailsController.summaryResult[0])
                  ),
                ):NoDataFound(iconData: Icons.cloud_off),
              ],
            ),
          ),
        ),
      );
    }));
  }

  Widget _itemView(ResultSummary summaryResult) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
              _dataItem("Open",summaryResult.price!.regularMarketOpen!.fmt!),
              _dataItem("Close",summaryResult.price!.regularMarketPreviousClose!.fmt!),
          ],
        ),
        Row(
          children: [
            _dataItem("Day High",summaryResult.price!.regularMarketDayHigh!.fmt!),
            _dataItem("Day Low",summaryResult.price!.regularMarketDayLow!.fmt!),
          ],
        ),
        Row(
          children: [
            _dataItem("Av.\nChange Points",summaryResult.price!.regularMarketChange!.fmt!),
            _dataItem("Av. Change\nPercentage",summaryResult.price!.regularMarketChangePercent!.fmt!),
          ],
        ),
        Row(
          children: [
            _dataItem("Volume",summaryResult.price!.regularMarketVolume!.fmt!),
            _dataItem("Market Cap",summaryResult.price!.marketCap!.fmt!),
          ],
        ),
        SizedBox(height: 1.h,),
        AdManager.getBannerAdUnitId()!=""?Container(
          height: 35.5.h,
          child: Align(
            alignment: Alignment.center,
            child: AdmobBanner(
              adUnitId: AdManager.getBannerAdUnitId()!,
              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
              listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                handleEvent(event, args, 'Banner');
              },
              onBannerCreated: (AdmobBannerController controller) {},
            ),
          ),
        ):SizedBox.shrink(),
        SizedBox(height: 1.h,),
        Row(
          children: [
            _dataItemInfo("CEO",summaryResult.assetProfile!.companyOfficers![0].name!.toString()),
          ],
        ),
        Row(
          children: [
            _dataItemInfo("Sector",summaryResult.assetProfile!.sector.toString()),
          ],
        ),
        Row(
          children: [
            _dataItemInfo("Exchange",summaryResult.price!.exchangeName!.toString()),
          ],
        ),
      ],
    );
  }

  _dataItem(String title, String value) {
    int flag=0;
    if(value.contains("-")){
      flag=1;
    }else{
      flag=0;
    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
        margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        decoration: BoxDecoration(
          color: fontDarkCl.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child:Row(
          children: [
              Expanded(child: Text(title,style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),)),
              SizedBox(width: 1.w,),
              // Text(value,style: Theme.of(context).textTheme.headline4!.copyWith(color: flag==0?secondaryCl:Colors.red),),
              Text(value,style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white60),),
          ],
        ),
      ),
    );
  }

  _dataItemInfo(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
        margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child:Row(
          children: [
            Expanded(child: Text(title,style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white60),)),
            SizedBox(width: 1.w,),
            Text(value,style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),),
          ],
        ),
      ),
    );
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
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }

}
