import 'package:get/get.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:stock_market_app/app/modules/stockdetails/providers/details_provider.dart';
import 'package:stock_market_app/app/modules/stockdetails/views/chart_view.dart';

import '../chartdata_model.dart';
import '../details_model.dart';
import '../summary_data_model.dart';

class StockdetailsController extends GetxController {
  var isLoading = false.obs;
  // var chartData = <ChartData>[].obs;
  var chartDataValue = <ChartSampleData>[].obs;
  var candleChartDataValue = <CandleData>[].obs;
  var summaryResult=<ResultSummary>[].obs;
  var reports=<Report>[].obs;
  static List<dynamic> _rawDataNew = [].obs;
  var candlesData= <CandleData>[].obs;
  static List<CandleData> get candles => _rawDataNew
      .map((row) => CandleData(
    timestamp: row[0] * 1000,
    open: row[1]?.toDouble(),
    high: row[2]?.toDouble(),
    low: row[3]?.toDouble(),
    close: row[4]?.toDouble(),
    volume: row[5]?.toDouble(),
  )).toList().obs;

  RxInt minimumValue = 0.obs;
  RxInt maximumValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> callGetChartData(String flag, String ticker, String intevalType) async {
    try {
      isLoading(true);
      candlesData.clear();
      _rawDataNew.clear();
      ChartResponce chartResponce = await DetailsProvider().getChartData(flag, ticker,intevalType);
      if (chartResponce.chart!.result != null && chartResponce.chart!.result!.length > 0) {
        List<int> timestamp=chartResponce.chart!.result![0].timestamp!;
        print("---- timestamp length----"+timestamp.length.toString());
        double openValue=0.0;
        double closeValue=0.0;
        for (var i = 0; i < timestamp.length; i++) {
          List<dynamic> tempData=[];
          tempData.add(timestamp[i]);
          if(i==0){
            openValue=chartResponce.chart!.result![0].indicators!.quote![0].high![i].toDouble();
            closeValue=chartResponce.chart!.result![0].indicators!.quote![0].close![i].toDouble();
          }else{
            if(openValue<chartResponce.chart!.result![0].indicators!.quote![0].high![i].toDouble()){
              openValue=chartResponce.chart!.result![0].indicators!.quote![0].high![i].toDouble();
            }
            if(closeValue>chartResponce.chart!.result![0].indicators!.quote![0].close![i].toDouble()){
              closeValue=chartResponce.chart!.result![0].indicators!.quote![0].close![i].toDouble();
            }
          }
          tempData.add(chartResponce.chart!.result![0].indicators!.quote![0].open![i].toDouble());
          tempData.add(chartResponce.chart!.result![0].indicators!.quote![0].high![i].toDouble());
          tempData.add(chartResponce.chart!.result![0].indicators!.quote![0].low![i].toDouble());
          tempData.add(chartResponce.chart!.result![0].indicators!.quote![0].close![i].toDouble());
          tempData.add(chartResponce.chart!.result![0].indicators!.quote![0].volume![i].toDouble().toPrecision(0));
          _rawDataNew.add(tempData);
        }
        print("---- _rawDataNew length----"+_rawDataNew.length.toString());
        print("---- openValue----"+openValue.toString());
        print("---- closeValue----"+closeValue.toString());

        if(_rawDataNew.isNotEmpty){
          candlesData.addAll(
              _rawDataNew.map((row) => CandleData(
                timestamp: row[0] * 1000,
                open: row[1]?.toDouble(),
                high: row[2]?.toDouble(),
                low: row[3]?.toDouble(),
                close: row[4]?.toDouble(),
                volume: row[5]?.toDouble(),
              )).toList()
          );
        }

      }
    } finally {
      isLoading(false);
    }
  }

  void callGetSummaryData(String ticker) async {
    try {
      // isLoading(true);
      SummaryResponce summaryResponce = await DetailsProvider().getSummaryData(ticker);
      if(summaryResponce.quoteSummary!.result!.length>0){
        summaryResult.addAll(summaryResponce.quoteSummary!.result!);
      }
    } finally {
      // isLoading(false);
    }
  }

  void callGetInsightsData(String ticker) async {
    try {
      isLoading(true);
      DetailsResponce summaryResponce = await DetailsProvider().getInsightsData(ticker);
      if(summaryResponce.finance!.result!.reports!.length>0){
        reports.addAll(summaryResponce.finance!.result!.reports!);
      }
    } finally {
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
