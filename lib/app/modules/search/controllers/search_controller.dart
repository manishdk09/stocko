import 'package:get/get.dart';
import '../../home/maindata_responce.dart';
import '../../home/providers/maindata_list_provider.dart';
import '../providers/search_provider.dart';
import '../search_responce.dart';

class SearchController extends GetxController  {

  var isLoading= false.obs;
  var quotes=<Quote>[].obs;
  var resultData=<ResultData>[].obs;
  String symbol="";

  @override
  void onInit() {
    super.onInit();
  }

  void callSearchApi(String text) async{
    try{
      isLoading(true);
      SearchResponce searchResponce=await SearchProvider().getSearch(text);
      if(searchResponce!=null){
        String symbol="";
        if(searchResponce.quotes!.length>0){
          for(var i=0;i<searchResponce.quotes!.length;i++){
            String ticker=searchResponce.quotes![i].symbol!;
            if(i==0){
              symbol=ticker;
            }else{
              symbol=symbol+","+ticker;
            }
          }
          print("Symbol=="+symbol);
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
