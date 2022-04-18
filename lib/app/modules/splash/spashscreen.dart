import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:stock_market_app/app/utils/constants/image_constant.dart';

import '../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _start = 4;
  var storage;

  @override
  void initState() {
    super.initState();
    storage=GetStorage();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryCl,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
                width: 35.w,
                height: 35.w,
                decoration: BoxDecoration(
                  // color: primaryCl,
                  borderRadius: BorderRadius.circular(50.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              child: Image.asset(DImg.lOGO,width: 35.w,height: 35.w,)
            ),
            Container(
              child: Image.asset(DImg.nameLogo,width: 45.w,height: 30.w,),
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          storage.write("SP",true);
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

}
