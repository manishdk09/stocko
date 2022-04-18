// To parse this JSON data, do
//
//     final chartResponce = chartResponceFromJson(jsonString);

import 'dart:convert';

ChartResponce chartResponceFromJson(String str) => ChartResponce.fromJson(json.decode(str));

String chartResponceToJson(ChartResponce data) => json.encode(data.toJson());

class ChartResponce {
  ChartResponce({
    this.chart,
  });

  Chart? chart;

  factory ChartResponce.fromJson(Map<String, dynamic> json) => ChartResponce(
    chart: Chart.fromJson(json["chart"]),
  );

  Map<String, dynamic> toJson() => {
    "chart": chart!.toJson(),
  };
}

class Chart {
  Chart({
    this.result,
    this.error,
  });

  List<ResultChartData>? result;
  dynamic error;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
    result: List<ResultChartData>.from(json["result"].map((x) => ResultChartData.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "error": error,
  };
}

class ResultChartData {
  ResultChartData({
    this.meta,
    this.timestamp,
    this.indicators,
  });

  Meta? meta;
  List<int>? timestamp;
  Indicators? indicators;

  factory ResultChartData.fromJson(Map<String, dynamic> json) => ResultChartData(
    meta:json["meta"]!=null? Meta.fromJson(json["meta"]):null,
    timestamp: List<int>.from(json["timestamp"].map((x) => x)),
    indicators: Indicators.fromJson(json["indicators"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta!.toJson(),
    "timestamp": List<dynamic>.from(timestamp!.map((x) => x)),
    "indicators": indicators!.toJson(),
  };
}

class Indicators {
  Indicators({
    this.quote,
  });

  List<QuoteChartData>? quote;

  factory Indicators.fromJson(Map<String, dynamic> json) => Indicators(
    quote: List<QuoteChartData>.from(json["quote"].map((x) => QuoteChartData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quote": List<dynamic>.from(quote!.map((x) => x.toJson())),
  };
}

class QuoteChartData {
  QuoteChartData({
    this.high,
    this.close,
    this.low,
    this.open,
    this.volume,
  });

  List<double>? high;
  List<double>? close;
  List<double>? low;
  List<double>? open;
  List<double>? volume;

  factory QuoteChartData.fromJson(Map<String, dynamic> json) => QuoteChartData(
    high:List<double>.from(json["high"].map((x) => x == null ? 0.0 : x.toDouble())),
    close: List<double>.from(json["close"].map((x) => x == null ? 0.0 : x.toDouble())),
    low: List<double>.from(json["low"].map((x) => x == null ? 0.0 : x.toDouble())),
    open: List<double>.from(json["open"].map((x) => x == null ? 0.0 : x.toDouble())),
    volume: List<double>.from(json["volume"].map((x) => x == null ? 0.0 : x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "high": List<dynamic>.from(high!.map((x) => x == null ? 0.0 : x)),
    "close": List<dynamic>.from(close!.map((x) => x == null ? 0.0 : x)),
    "low": List<dynamic>.from(low!.map((x) => x == null ? 0.0 : x)),
    "open": List<dynamic>.from(open!.map((x) => x == null ? 0.0 : x)),
    "volume": List<dynamic>.from(volume!.map((x) => x == null ? 0.0 : x)),
  };
}

class Meta {
  Meta({
    this.currency,
    this.symbol,
    this.exchangeName,
    this.instrumentType,
    this.firstTradeDate,
    this.regularMarketTime,
    this.gmtoffset,
    this.timezone,
    this.exchangeTimezoneName,
    this.regularMarketPrice,
    this.chartPreviousClose,
    this.previousClose,
    this.scale,
    this.priceHint,
    this.currentTradingPeriod,
    this.tradingPeriods,
    this.dataGranularity,
    this.range,
    this.validRanges,
  });

  String? currency;
  String? symbol;
  String? exchangeName;
  String? instrumentType;
  int? firstTradeDate;
  int? regularMarketTime;
  int? gmtoffset;
  String? timezone;
  String? exchangeTimezoneName;
  double? regularMarketPrice;
  double? chartPreviousClose;
  double? previousClose;
  int? scale;
  int? priceHint;
  CurrentTradingPeriod? currentTradingPeriod;
  List<List<Post>>? tradingPeriods;
  String? dataGranularity;
  String? range;
  List<String>? validRanges;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currency: json["currency"],
    symbol: json["symbol"],
    exchangeName: json["exchangeName"],
    instrumentType: json["instrumentType"],
    firstTradeDate: json["firstTradeDate"],
    regularMarketTime: json["regularMarketTime"],
    gmtoffset: json["gmtoffset"],
    timezone: json["timezone"],
    exchangeTimezoneName: json["exchangeTimezoneName"],
    regularMarketPrice:json["regularMarketPrice"]!=null? json["regularMarketPrice"].toDouble():0.0,
    chartPreviousClose:json["chartPreviousClose"]!=null? json["chartPreviousClose"].toDouble():0.0,
    previousClose:json["previousClose"]!=null? json["previousClose"].toDouble():0.0,
    scale: json["scale"],
    priceHint: json["priceHint"],
    currentTradingPeriod: CurrentTradingPeriod.fromJson(json["currentTradingPeriod"]),
    // tradingPeriods: List<List<Post>>.from(json["tradingPeriods"].map((x) => List<Post>.from(x.map((x) => Post.fromJson(x))))),
    dataGranularity: json["dataGranularity"],
    range: json["range"],
    validRanges: List<String>.from(json["validRanges"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "symbol": symbol,
    "exchangeName": exchangeName,
    "instrumentType": instrumentType,
    "firstTradeDate": firstTradeDate,
    "regularMarketTime": regularMarketTime,
    "gmtoffset": gmtoffset,
    "timezone": timezone,
    "exchangeTimezoneName": exchangeTimezoneName,
    "regularMarketPrice": regularMarketPrice,
    "chartPreviousClose": chartPreviousClose,
    "previousClose": previousClose,
    "scale": scale,
    "priceHint": priceHint,
    "currentTradingPeriod": currentTradingPeriod!.toJson(),
    "tradingPeriods": List<dynamic>.from(tradingPeriods!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "dataGranularity": dataGranularity,
    "range": range,
    "validRanges": List<dynamic>.from(validRanges!.map((x) => x)),
  };
}

class CurrentTradingPeriod {
  CurrentTradingPeriod({
    this.pre,
    this.regular,
    this.post,
  });

  Post? pre;
  Post? regular;
  Post? post;

  factory CurrentTradingPeriod.fromJson(Map<String, dynamic> json) => CurrentTradingPeriod(
    pre: Post.fromJson(json["pre"]),
    regular: Post.fromJson(json["regular"]),
    post: Post.fromJson(json["post"]),
  );

  Map<String, dynamic> toJson() => {
    "pre": pre!.toJson(),
    "regular": regular!.toJson(),
    "post": post!.toJson(),
  };
}

class Post {
  Post({
    this.timezone,
    this.start,
    this.end,
    this.gmtoffset,
  });

  String? timezone;
  int? start;
  int? end;
  int? gmtoffset;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    timezone: json["timezone"],
    start: json["start"],
    end: json["end"],
    gmtoffset: json["gmtoffset"],
  );

  Map<String, dynamic> toJson() => {
    "timezone": timezone,
    "start": start,
    "end": end,
    "gmtoffset": gmtoffset,
  };
}
