// To parse this JSON data, do
//
//     final mainDatalResponce = mainDatalResponceFromJson(jsonString);

import 'dart:convert';

MainDatalResponce mainDatalResponceFromJson(String str) => MainDatalResponce.fromJson(json.decode(str));

String mainDatalResponceToJson(MainDatalResponce data) => json.encode(data.toJson());

class MainDatalResponce {
  MainDatalResponce({
    this.quoteResponse,
  });

  QuoteResponse? quoteResponse;

  factory MainDatalResponce.fromJson(Map<String, dynamic> json) => MainDatalResponce(
    quoteResponse: QuoteResponse.fromJson(json["quoteResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "quoteResponse": quoteResponse!.toJson(),
  };
}

class QuoteResponse {
  QuoteResponse({
    this.result,
    this.error,
  });

  List<ResultData>? result;
  dynamic error;

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
    result: List<ResultData>.from(json["result"].map((x) => ResultData.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "error": error,
  };
}

class ResultData {
  ResultData({
    this.fullExchangeName,
    this.symbol,
    this.gmtOffSetMilliseconds,
    this.language,
    this.regularMarketTime,
    this.regularMarketChangePercent,
    this.quoteType,
    this.typeDisp,
    this.tradeable,
    this.regularMarketPreviousClose,
    this.exchangeTimezoneName,
    this.regularMarketChange,
    this.firstTradeDateMilliseconds,
    this.exchangeDataDelayedBy,
    this.exchangeTimezoneShortName,
    this.customPriceAlertConfidence,
    this.marketState,
    this.regularMarketPrice,
    this.market,
    this.quoteSourceName,
    this.priceHint,
    this.sourceInterval,
    this.exchange,
    this.shortName,
    this.region,
    this.triggerable,
    this.longName,
  });

  String? fullExchangeName;
  String? symbol;
  int? gmtOffSetMilliseconds;
  String? language;
  RegularMarket? regularMarketTime;
  RegularMarket? regularMarketChangePercent;
  String? quoteType;
  String? typeDisp;
  bool? tradeable;
  RegularMarket? regularMarketPreviousClose;
  String? exchangeTimezoneName;
  RegularMarket? regularMarketChange;
  int? firstTradeDateMilliseconds;
  int? exchangeDataDelayedBy;
  String? exchangeTimezoneShortName;
  String? customPriceAlertConfidence;
  String? marketState;
  RegularMarket? regularMarketPrice;
  String? market;
  String? quoteSourceName;
  int? priceHint;
  int? sourceInterval;
  String? exchange;
  String? shortName;
  String? region;
  bool? triggerable;
  String? longName;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    fullExchangeName: json["fullExchangeName"],
    symbol: json["symbol"],
    gmtOffSetMilliseconds: json["gmtOffSetMilliseconds"],
    language: json["language"],
    regularMarketTime: RegularMarket.fromJson(json["regularMarketTime"]),
    regularMarketChangePercent:json["regularMarketChangePercent"]!=null? RegularMarket.fromJson(json["regularMarketChangePercent"]):null,
    quoteType: json["quoteType"],
    typeDisp: json["typeDisp"],
    tradeable: json["tradeable"],
    regularMarketPreviousClose: json["regularMarketPreviousClose"] == null ? null : RegularMarket.fromJson(json["regularMarketPreviousClose"]),
    exchangeTimezoneName: json["exchangeTimezoneName"],
    regularMarketChange: RegularMarket.fromJson(json["regularMarketChange"]),
    firstTradeDateMilliseconds: json["firstTradeDateMilliseconds"] == null ? null : json["firstTradeDateMilliseconds"],
    exchangeDataDelayedBy: json["exchangeDataDelayedBy"],
    exchangeTimezoneShortName: json["exchangeTimezoneShortName"],
    customPriceAlertConfidence: json["customPriceAlertConfidence"],
    marketState: json["marketState"],
    regularMarketPrice: RegularMarket.fromJson(json["regularMarketPrice"]),
    market: json["market"],
    quoteSourceName: json["quoteSourceName"],
    priceHint: json["priceHint"],
    sourceInterval: json["sourceInterval"],
    exchange: json["exchange"],
    shortName: json["shortName"] == null ? null : json["shortName"],
    region: json["region"],
    triggerable: json["triggerable"],
    longName: json["longName"],
  );

  Map<String, dynamic> toJson() => {
    "fullExchangeName": fullExchangeName,
    "symbol": symbol,
    "gmtOffSetMilliseconds": gmtOffSetMilliseconds,
    "language": language,
    "regularMarketTime": regularMarketTime!.toJson(),
    "regularMarketChangePercent": regularMarketChangePercent!.toJson(),
    "quoteType":quoteType,
    "typeDisp": typeDisp,
    "tradeable": tradeable,
    "regularMarketPreviousClose": regularMarketPreviousClose == null ? null : regularMarketPreviousClose!.toJson(),
    "exchangeTimezoneName": exchangeTimezoneName,
    "regularMarketChange": regularMarketChange!.toJson(),
    "firstTradeDateMilliseconds": firstTradeDateMilliseconds == null ? null : firstTradeDateMilliseconds,
    "exchangeDataDelayedBy": exchangeDataDelayedBy,
    "exchangeTimezoneShortName": exchangeTimezoneShortName,
    "customPriceAlertConfidence": customPriceAlertConfidence,
    "marketState": marketState,
    "regularMarketPrice": regularMarketPrice!.toJson(),
    "market": market,
    "quoteSourceName": quoteSourceName,
    "priceHint": priceHint,
    "sourceInterval": sourceInterval,
    "exchange": exchange,
    "shortName": shortName == null ? null : shortName,
    "region": region,
    "triggerable": triggerable,
    "longName": longName,
  };
}

class RegularMarket {
  RegularMarket({
    this.raw,
    this.fmt,
  });

  double? raw;
  String? fmt;

  factory RegularMarket.fromJson(Map<String, dynamic> json) => RegularMarket(
    raw: json["raw"].toDouble(),
    fmt: json["fmt"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "fmt": fmt,
  };
}


