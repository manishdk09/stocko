import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Admob.initialize();
  bool isShow=false;
  var storage=GetStorage();
  if(storage.hasData("SP")){
    isShow=storage.read("SP");
  }
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      title: DStr.stockMarket,
      debugShowCheckedModeBanner: false,
      initialRoute:isShow?AppPages.INITIAL:AppPages.INITIALSP,
      getPages: AppPages.routes,
      theme: darkThemeData(),
    );
  }));
}
