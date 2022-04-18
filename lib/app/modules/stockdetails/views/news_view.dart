import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/stockdetails/controllers/stockdetails_controller.dart';
import 'package:stock_market_app/app/utils/AdManager.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/color_constant.dart';
import '../../../utils/constants/string_constant.dart';
import '../../../utils/no_data_found.dart';
import '../../home/maindata_responce.dart';

class NewsView extends StatefulWidget {
  final String? argument;
  final ResultData? resultData;

  const NewsView({Key? key, this.argument, this.resultData}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  StockdetailsController _stockdetailsController =
      Get.put(StockdetailsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _stockdetailsController.callGetInsightsData(widget.argument!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_stockdetailsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else
          return _newsList();
      }),
    );
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
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }

  Widget _newsList() {
    return Container(
        margin: EdgeInsets.only(top: 2.h),
        child: _stockdetailsController.reports.length > 0
            ? ListView.builder(
                itemCount: _stockdetailsController.reports.length,
                itemBuilder: (contex, index) {
                  String title = _stockdetailsController.reports[index].title!;
                  String description =
                      _stockdetailsController.reports[index].summary!;
                  String provider =
                      _stockdetailsController.reports[index].provider!;
                  String publishedDate =
                      _stockdetailsController.reports[index].publishedOn!;

                  return index % 2 == 0 && index != 0
                      ? Column(
                          children: [
                            index > 3? InkWell(
                              onTap: () {
                                _launchInBrowser(DStr.clickLink);
                              },
                              child:AdManager.getQurekaNativeId()!=""? Container(
                                height: 35.h,
                                child: Image.network(
                                  AdManager.getQurekaNativeId()??"",
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ):SizedBox.shrink(),
                            ):AdManager.getBannerAdUnitId()!=""?Container(
                              height: 35.5.h,
                              child: Align(
                                alignment: Alignment(0, 1.0),
                                child: AdmobBanner(
                                  adUnitId: AdManager.getBannerAdUnitId() ?? "",
                                  adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                                  listener: (AdmobAdEvent event,
                                      Map<String, dynamic>? args) {
                                    handleEvent(event, args, 'Banner');
                                  },
                                  onBannerCreated:
                                      (AdmobBannerController controller) {},
                                ),
                              ),
                            ):InkWell(
                              onTap: () {
                                _launchInBrowser(DStr.clickLink);
                              },
                              child:AdManager.getQurekaNativeId()!=""? Container(
                                height: 35.h,
                                child: Image.network(
                                  AdManager.getQurekaNativeId()??"",
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ):SizedBox.shrink(),
                            ),
                            Container(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 1.5.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
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
                                            height: 0.8.h,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
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
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.h),
                                            child: Text(
                                              "${provider}",
                                              maxLines: 1,
                                              softWrap: true,
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.h),
                                            child: Text(
                                              "${timeago.format(DateTime.parse(publishedDate).toLocal())}",
                                              maxLines: 1,
                                              softWrap: true,
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white60),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
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
                                        height: 0.8.h,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              description,
                                              maxLines: 3,
                                              softWrap: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(color: fontDarkCl),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0.h),
                                        child: Text(
                                          "${provider}",
                                          maxLines: 1,
                                          softWrap: true,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0.h),
                                        child: Text(
                                          "${timeago.format(DateTime.parse(publishedDate).toLocal())}",
                                          maxLines: 1,
                                          softWrap: true,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white60),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                })
            : NoDataFound(
                iconData: Icons.cloud_off,
              ));
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    )) {
      throw 'Could not launch $url';
    }
  }
}
