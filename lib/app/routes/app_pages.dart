import 'package:get/get.dart';
import 'package:stock_market_app/app/modules/dashboard.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/spashscreen.dart';
import '../modules/stockdetails/bindings/stockdetails_binding.dart';
import '../modules/stockdetails/views/stockdetails_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIALSP = Routes.SPLASH;
  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashBoard(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.STOCKDETAILS,
      page: () => StockdetailsView(),
      binding: StockdetailsBinding(),
    ),
  ];
}
