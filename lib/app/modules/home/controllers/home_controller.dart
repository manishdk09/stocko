import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';

import '../ads_responce.dart';
import '../maindata_responce.dart';
import '../news_model.dart';
import '../providers/maindata_list_provider.dart';
import '../providers/news_list_provider.dart';
import '../providers/symbol_list_provider.dart';
import '../symbol_model.dart';
import '../version_model.dart';

class HomeController extends GetxController {

  var isLoading= false.obs;
  var stocksNews=<StocksNew>[].obs;
  var resultData=<ResultData>[].obs;
  var resultDataFavo=<ResultData>[].obs;
  String version="";
  String symbol="";
  // List<StocksNew>? stocksNews.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getAdvertise() async{
    bool result=true;
    try{
      isLoading(true);
      AdsResponce adsResponce=await SymbolProvider().getAdvertise();
      if(adsResponce!=null){
        for(int i=0;i<=adsResponce.googleAds!.interstitial!.length;i++){
          DStr.G_INTERSTITIAL=adsResponce.googleAds!.interstitial![0].toString();
          DStr.G_INTERSTITIAL2=adsResponce.googleAds!.interstitial![1].toString();
        }
        for(int i=0;i<=adsResponce.googleAds!.nativeBanner!.length;i++){
          DStr.gg_nat_bnr=adsResponce.googleAds!.nativeBanner![0].toString();
          DStr.gg_nat_bnr2=adsResponce.googleAds!.nativeBanner![1].toString();
        }
        for(int i=0;i<=adsResponce.googleAds!.native!.length;i++){
          DStr.gg_native=adsResponce.googleAds!.native![0].toString();
          DStr.gg_native2=adsResponce.googleAds!.native![1].toString();
        }
        DStr.banner_1=adsResponce.qurekaAds!.adsImages!.banner1!;
        DStr.banner_2=adsResponce.qurekaAds!.adsImages!.banner2!;
        DStr.banner_3=adsResponce.qurekaAds!.adsImages!.banner3!;
        DStr.banner_4=adsResponce.qurekaAds!.adsImages!.banner4!;
        DStr.native_1=adsResponce.qurekaAds!.adsImages!.native1!;
        DStr.native_2=adsResponce.qurekaAds!.adsImages!.native2!;
        DStr.native_3=adsResponce.qurekaAds!.adsImages!.native3!;
        DStr.native_4=adsResponce.qurekaAds!.adsImages!.native4!;
        DStr.native_5=adsResponce.qurekaAds!.adsImages!.native5!;
        DStr.native_6=adsResponce.qurekaAds!.adsImages!.native6!;
        DStr.interstitial_1=adsResponce.qurekaAds!.adsImages!.interstitial1!;
        DStr.interstitial_2=adsResponce.qurekaAds!.adsImages!.interstitial2!;
        DStr.interstitial_3=adsResponce.qurekaAds!.adsImages!.interstitial3!;
        DStr.interstitial_4=adsResponce.qurekaAds!.adsImages!.interstitial4!;
        DStr.clickLink=adsResponce.qurekaAds!.adLink!;
        DStr.clickCount=adsResponce.clickCount!;
      }
    }
    finally{
      isLoading(false);
    }
    return result;
  }

  Future<bool> getVersion() async{
    bool result=true;
    try{
      isLoading(true);
      VersionResponce versionResponce=await SymbolProvider().getVersion();
      if(versionResponce!=null){
          version = versionResponce.version!.value;
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String versiont = packageInfo.version;
          if(version==versiont){
            result=true;
          }else{
            result=false;
          }
      }
    }
    finally{
      isLoading(false);
    }
    return result;
  }

  void getSymbol() async{
    try{
      isLoading(true);
      SymbolResponce symbolResponce=await SymbolProvider().getSymbol();
      if(symbolResponce!=null){
        if(symbolResponce.finance!.result!.length>0){
          for(var i=0; i<symbolResponce.finance!.result!.length;i++){
            Result result=symbolResponce.finance!.result![i];
            if(result.quotes!.length>0){
              for(var i=0; i<result.quotes!.length;i++){
                String ticker=result.quotes![i].symbol!;
                if(i==0){
                  symbol=ticker;
                }else{
                  symbol=symbol+","+ticker;
                }
              }
              print("Symbol=="+symbol);
            }
          }
          if(symbol!=""){
            getMainData(symbol);
          }
        }
      }
    }
    finally{
      isLoading(false);
    }
  }

  Future<void> getSymbolRefresh() async{
    try{
      isLoading(true);
      SymbolResponce symbolResponce=await SymbolProvider().getSymbol();
      if(symbolResponce!=null){
        if(symbolResponce.finance!.result!.length>0){
          for(var i=0; i<symbolResponce.finance!.result!.length;i++){
            Result result=symbolResponce.finance!.result![i];
            if(result.quotes!.length>0){
              for(var i=0; i<result.quotes!.length;i++){
                String ticker=result.quotes![i].symbol!;
                if(i==0){
                  symbol=ticker;
                }else{
                  symbol=symbol+","+ticker;
                }
              }
              print("Symbol=="+symbol);
            }
          }
          if(symbol!=""){
            getMainData(symbol);
          }
        }
      }
    }
    finally{
      isLoading(false);
    }
  }

  void getMainData(String symbol) async{
    try{
      isLoading(true);
      MainDatalResponce mainDatalResponce=await MainDataProvider().getSymbolData(symbol);
      if(mainDatalResponce!=null){
        if(mainDatalResponce.quoteResponse!.result!.length>0){
          if(resultData.length>0){
            resultData.clear();
          }
          resultData.addAll(mainDatalResponce.quoteResponse!.result!);
        }
      }
    }
    finally{
      isLoading(false);
    }
  }

  void getMainDataFavo(String symbol) async{
    try{
      isLoading(true);
      MainDatalResponce mainDatalResponce=await MainDataProvider().getSymbolData(symbol);
      if(mainDatalResponce!=null){
        if(mainDatalResponce.quoteResponse!.result!.length>0){
          if(resultDataFavo.length>0){
            resultDataFavo.clear();
          }
          resultDataFavo.addAll(mainDatalResponce.quoteResponse!.result!);
        }
      }
    }
    finally{
      isLoading(false);
    }
  }

  void getNews() async{
    try{
      isLoading(true);
      NewsResponce newsResponce=await NewsListProvider().getNews();
      if(newsResponce.data!=null && newsResponce.data!.stocksNews!.length>0){
        stocksNews.addAll(newsResponce.data!.stocksNews!);
      }
    }
    finally{
      isLoading(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
