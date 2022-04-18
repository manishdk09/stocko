import 'package:dio/dio.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';
import '../../../utils/constants/url_constant.dart';
import '../ads_responce.dart';
import '../symbol_model.dart';
import '../version_model.dart';

class SymbolProvider{

  /**
   * Get Symbol
   */
  Future<SymbolResponce> getSymbol() async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    late SymbolResponce _responce;
    try {
      final response = await _dio.get(DUrl.getSymbol);
      responseJson = response.data;
      if(responseJson!=null){
        _responce = SymbolResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

  /**
   * Get Version
   */
  Future<VersionResponce> getVersion() async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL2,
    );
    Dio _dio = Dio(options);
    // late WatchList responseJson;
    var responseJson;
    late VersionResponce _responce;
    try {
      final response = await _dio.get(DUrl.getVersion);
      responseJson = response.data;
      if(responseJson!=null){
        _responce = VersionResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

  /**
   * Get Advertisement
   */
  Future<AdsResponce> getAdvertise() async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL3,
    );
    Dio _dio = Dio(options);
    var responseJson;
    late AdsResponce _responce;
    try {
      final response = await _dio.get("panel_of_admin_application/api_of_applications/stocks_ads_api");
      print(response);
      responseJson = response.data;
      if(responseJson!=null){
        _responce = AdsResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }




}
