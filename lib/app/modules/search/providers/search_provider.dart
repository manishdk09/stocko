import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_app/app/utils/constants/string_constant.dart';

import '../../../utils/constants/url_constant.dart';
import '../../search/search_responce.dart';


class SearchProvider{
  Future<SearchResponce> getSearch(String text) async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    late SearchResponce _responce;
    try {
      final response = await _dio.get("v1/finance/search?newsCount=0&enableFuzzyQuery=false&enableEnhancedTrivialQuery=true&region=US&lang=en-US &quotesCount=5&q="+text);
      responseJson = response.data;
      debugPrint(responseJson.toString());
      if(responseJson!=null){
        _responce = SearchResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

}
