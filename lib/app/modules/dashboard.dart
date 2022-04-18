import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/modules/home/views/news.dart';
import 'package:stock_market_app/app/modules/search/views/search_view.dart';
import 'package:stock_market_app/app/modules/settings/views/settings_view.dart';
import 'package:stock_market_app/app/utils/AdManager.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants/string_constant.dart';
import 'home/controllers/home_controller.dart';
import 'home/views/home_view.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  Map _source = {ConnectivityResult.none: false};
  late AdmobInterstitial interstitialAd;

  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    News(),
    SearchView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    DStr.currenCountCount=DStr.currenCountCount+1;
    if(DStr.clickCount==DStr.currenCountCount){
      DStr.currenCountCount=0;
      showAds();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  // event handler for ads
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

  /**
   * Internet connection check
   */
  void checkConnection() async {
    hasNetwork().then((value) => {
          if (value)
            {
              // api call
              _homeController = Get.put(HomeController()),
              _homeController.getAdvertise(),
              _homeController.getVersion().then((value) => {
                    if (!value)
                      {
                        showDialodVersion(),
                      }
                  }),

              // laod and intialise intertial Ads.
              interstitialAd = AdmobInterstitial(
                adUnitId: AdManager.getInterstitialAdUnitId()!,
                listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                  if (event == AdmobAdEvent.closed) interstitialAd.load();
                  handleEvent(event, args, 'Interstitial');
                },
              ),
              interstitialAd.load(),
            }
          else
            {showDialod()}
        });
  }

  // check hase network
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryCl,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex,
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: _inActiveIcon(Icons.home),
              label: "Home",
              activeIcon: _activeIcons(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: _inActiveIcon(Icons.event_note),
              label: "News",
              activeIcon: _activeIcons(Icons.event_note),
            ),
            BottomNavigationBarItem(
              icon: _inActiveIcon(Icons.search),
              label: "Search",
              activeIcon: _activeIcons(Icons.search),
            ),
            BottomNavigationBarItem(
              icon: _inActiveIcon(Icons.settings_outlined),
              label: "Settings",
              activeIcon: _activeIcons(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * OnBackpress click....
   */
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:
                new Text('Exit?', style: Theme.of(context).textTheme.headline3),
            content: new Text('Do you want to exit an App',
                style: Theme.of(context).textTheme.headline4),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No',
                    style: Theme.of(context).textTheme.headline3),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes',
                    style: Theme.of(context).textTheme.headline3),
              ),
            ],
          ),
        )) ??
        false;
  }

  /**
   * Bottom Icons.....
   */
  Widget _inActiveIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 22.sp,
      color: Colors.white70,
    );
  }

  Widget _activeIcons(IconData iconData) {
    return Icon(
      iconData,
      size: 22.sp,
      color: Colors.white,
    );
  }

  /**
   * Internet Icon.......
   */
  void showDialod() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('No Internet',
            style: Theme.of(context).textTheme.headline3),
        content: new Text('No Internet, please turn you internet connection!',
            style: Theme.of(context).textTheme.headline4),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Ok', style: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }

  /**
   * Show Version update dialog
   */
  void showDialodVersion() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
        title: new Text('Update App',
            style: Theme.of(context).textTheme.headline3),
        content: new Text('Please update your application version!',
            style: Theme.of(context).textTheme.headline4),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: new Text('CLOSE', style: Theme.of(context).textTheme.headline3),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              _launchURL();
            },
            child: new Text('UPDATE', style: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }

  // redirect to play store application for update app.
  void _launchURL() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String _url =
        "https://play.google.com/store/apps/details?id=" + packageName;
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
