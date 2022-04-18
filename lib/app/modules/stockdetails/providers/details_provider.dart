import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_app/app/utils/constants/url_constant.dart';

import '../chartdata_model.dart';
import '../details_model.dart';
import '../summary_data_model.dart';

class DetailsProvider{

  Future<ChartResponce> getChartData(String dayType,String ticker,String inteval) async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    ChartResponce _responce=new ChartResponce();
    try {
      print("----URL---"+"v8/finance/chart/"+ticker+"?interval="+inteval+"&range="+dayType);
      final response = await _dio.get("v8/finance/chart/"+ticker+"?interval="+inteval+"&range="+dayType);
      print('response chart --> ${response.data}');
      responseJson = response.data;
      if(responseJson!=null){
        _responce = ChartResponce.fromJson(responseJson);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

  Future<SummaryResponce> getSummaryData(String ticker) async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    SummaryResponce _responce=new SummaryResponce();
    try {
      final response = await _dio.get("v11/finance/quoteSummary/"+ticker+"?lang=en&region=US&modules=assetProfile,price");
      responseJson = response.data;
      if(responseJson!=null){
        _responce = SummaryResponce.fromJson(responseJson);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

  Future<DetailsResponce> getInsightsData(String ticker) async {
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL,
    );
    Dio _dio = Dio(options);
    var responseJson;
    DetailsResponce _responce=new DetailsResponce();
    try {
      final response = await _dio.get("ws/insights/v1/finance/insights?symbol="+ticker);
      debugPrint("**"+response.toString());
      responseJson = response.data;
      if(responseJson!=null){
        _responce = DetailsResponce.fromJson(responseJson);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

}
