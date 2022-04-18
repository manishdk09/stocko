import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/controllers/stockdetails_controller.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/no_data_found.dart';

import '../../../utils/AdManager.dart';
import '../../home/maindata_responce.dart';

class SummaryView extends StatefulWidget {
  final String? argument;
  final ResultData? resultData;
  const SummaryView({Key? key, this.argument,this.resultData}) : super(key: key);
  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  StockdetailsController _stockdetailsController = Get.put(StockdetailsController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _stockdetailsController.callGetSummaryData(widget.argument!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Center(
        child: _stockdetailsController.isLoading.value
            ? CircularProgressIndicator(color: Colors.white,)
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.resultData!.longName!=null?Container(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Text(widget.resultData!.longName.toString(),maxLines: 2,style: Theme.of(context).textTheme.headline2),
                    ):SizedBox.shrink(),
                    _stockdetailsController.summaryResult.length > 0?Expanded(
                      child:_stockdetailsController.summaryResult[0].assetProfile!.longBusinessSummary!=null? SingleChildScrollView(
                        child: Container(
                          alignment:Alignment.topLeft,
                          padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 1.w),
                          child:Text(
                            "\t\t\t\t\t\t\t\t\t"+_stockdetailsController.summaryResult[0].assetProfile!.longBusinessSummary!.toString(),
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: fontDarkCl),
                          ),
                        ),
                      ):NoDataFound(iconData: Icons.cloud_off),
                    ):NoDataFound(iconData: Icons.cloud_off),
                    AdManager.getBannerAdUnitId()!=""?Container(
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
                  ],
                ),
              ),
      );
    }));
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
