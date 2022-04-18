import 'package:dio/dio.dart';
import 'package:stock_market_app/app/utils/constants/url_constant.dart';

import '../maindata_responce.dart';

class MainDataProvider{

  Future<MainDatalResponce> getSymbolData(String symbol) async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    late MainDatalResponce _responce;
    try {
      final response = await _dio.get(DUrl.getMainData1+symbol+DUrl.getMainData2);
      print(response);
      responseJson = response.data;
      if(responseJson!=null){
        _responce = MainDatalResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

}
