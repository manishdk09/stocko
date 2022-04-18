// To parse this JSON data, do
//
//     final summaryResponce = summaryResponceFromJson(jsonString);

import 'dart:convert';

SummaryResponce summaryResponceFromJson(String str) => SummaryResponce.fromJson(json.decode(str));

String summaryResponceToJson(SummaryResponce data) => json.encode(data.toJson());

class SummaryResponce {
  SummaryResponce({
    this.quoteSummary,
  });

  QuoteSummary? quoteSummary;

  factory SummaryResponce.fromJson(Map<String, dynamic> json) => SummaryResponce(
    quoteSummary: QuoteSummary.fromJson(json["quoteSummary"]),
  );

  Map<String, dynamic> toJson() => {
    "quoteSummary": quoteSummary!.toJson(),
  };
}

class QuoteSummary {
  QuoteSummary({
    this.result,
    this.error,
  });

  List<ResultSummary>? result;
  dynamic error;

  factory QuoteSummary.fromJson(Map<String, dynamic> json) => QuoteSummary(
    result:json["result"]!=null? List<ResultSummary>.from(json["result"].map((x) => ResultSummary.fromJson(x))):[],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "error": error,
  };
}

class ResultSummary {
  ResultSummary({
    this.assetProfile,
    this.price,
  });

  AssetProfile? assetProfile;
  Price? price;

  factory ResultSummary.fromJson(Map<String, dynamic> json) => ResultSummary(
    assetProfile: AssetProfile.fromJson(json["assetProfile"]),
    price: Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "assetProfile": assetProfile!.toJson(),
    "price": price!.toJson(),
  };
}

class AssetProfile {
  AssetProfile({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.phone,
    this.website,
    this.industry,
    this.sector,
    this.longBusinessSummary,
    this.fullTimeEmployees,
    this.companyOfficers,
    this.compensationAsOfEpochDate,
    this.maxAge,
  });

  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? phone;
  String? website;
  String? industry;
  String? sector;
  String? longBusinessSummary;
  int? fullTimeEmployees;
  List<CompanyOfficer>? companyOfficers;
  int? compensationAsOfEpochDate;
  int? maxAge;

  factory AssetProfile.fromJson(Map<String, dynamic> json) => AssetProfile(
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    country: json["country"],
    phone: json["phone"],
    website: json["website"],
    industry: json["industry"],
    sector: json["sector"],
    longBusinessSummary: json["longBusinessSummary"],
    fullTimeEmployees: json["fullTimeEmployees"],
    companyOfficers: List<CompanyOfficer>.from(json["companyOfficers"].map((x) => CompanyOfficer.fromJson(x))),
    compensationAsOfEpochDate: json["compensationAsOfEpochDate"],
    maxAge: json["maxAge"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
    "phone": phone,
    "website": website,
    "industry": industry,
    "sector": sector,
    "longBusinessSummary": longBusinessSummary,
    "fullTimeEmployees": fullTimeEmployees,
    "companyOfficers": List<dynamic>.from(companyOfficers!.map((x) => x.toJson())),
    "compensationAsOfEpochDate": compensationAsOfEpochDate,
    "maxAge": maxAge,
  };
}

class CompanyOfficer {
  CompanyOfficer({
    this.maxAge,
    this.name,
    this.age,
    this.title,
    this.yearBorn,
    this.fiscalYear,
    this.totalPay,
    this.exercisedValue,
    this.unexercisedValue,
  });

  int? maxAge;
  String? name;
  int? age;
  String? title;
  int? yearBorn;
  int? fiscalYear;
  MarketCap? totalPay;
  MarketCap? exercisedValue;
  MarketCap? unexercisedValue;

  factory CompanyOfficer.fromJson(Map<String, dynamic> json) => CompanyOfficer(
    maxAge: json["maxAge"],
    name: json["name"],
    age: json["age"] == null ? null : json["age"],
    title: json["title"],
    yearBorn: json["yearBorn"] == null ? null : json["yearBorn"],
    fiscalYear: json["fiscalYear"] == null ? null : json["fiscalYear"],
    totalPay: json["totalPay"] == null ? null : MarketCap.fromJson(json["totalPay"]),
    exercisedValue: MarketCap.fromJson(json["exercisedValue"]),
    unexercisedValue: MarketCap.fromJson(json["unexercisedValue"]),
  );

  Map<String, dynamic> toJson() => {
    "maxAge": maxAge,
    "name": name,
    "age": age == null ? null : age,
    "title": title,
    "yearBorn": yearBorn == null ? null : yearBorn,
    "fiscalYear": fiscalYear == null ? null : fiscalYear,
    "totalPay": totalPay == null ? null : totalPay!.toJson(),
    "exercisedValue": exercisedValue!.toJson(),
    "unexercisedValue": unexercisedValue!.toJson(),
  };
}

class MarketCap {
  MarketCap({
    this.raw,
    this.fmt,
    this.longFmt,
  });

  int? raw;
  String? fmt;
  String? longFmt;

  factory MarketCap.fromJson(Map<String, dynamic> json) => MarketCap(
    raw: json["raw"],
    fmt: json["fmt"] == null ? null : json["fmt"],
    longFmt: json["longFmt"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "fmt": fmt == null ? null : fmt,
    "longFmt": longFmt,
  };
}

class Price {
  Price({
    this.maxAge,
    this.preMarketChangePercent,
    this.preMarketChange,
    this.preMarketTime,
    this.preMarketPrice,
    this.preMarketSource,
    this.postMarketChangePercent,
    this.postMarketChange,
    this.postMarketTime,
    this.postMarketPrice,
    this.postMarketSource,
    this.regularMarketChangePercent,
    this.regularMarketChange,
    this.regularMarketTime,
    this.priceHint,
    this.regularMarketPrice,
    this.regularMarketDayHigh,
    this.regularMarketDayLow,
    this.regularMarketVolume,
    this.averageDailyVolume10Day,
    this.averageDailyVolume3Month,
    this.regularMarketPreviousClose,
    this.regularMarketSource,
    this.regularMarketOpen,
    this.strikePrice,
    this.openInterest,
    this.exchange,
    this.exchangeName,
    this.exchangeDataDelayedBy,
    this.marketState,
    this.quoteType,
    this.symbol,
    this.underlyingSymbol,
    this.shortName,
    this.longName,
    this.currency,
    this.quoteSourceName,
    this.currencySymbol,
    this.fromCurrency,
    this.toCurrency,
    this.lastMarket,
    this.volume24Hr,
    this.volumeAllCurrencies,
    this.circulatingSupply,
    this.marketCap,
  });

  int? maxAge;
  PostMarketChange? preMarketChangePercent;
  PostMarketChange? preMarketChange;
  int? preMarketTime;
  PostMarketChange? preMarketPrice;
  String? preMarketSource;
  PostMarketChange? postMarketChangePercent;
  PostMarketChange? postMarketChange;
  int? postMarketTime;
  PostMarketChange? postMarketPrice;
  String? postMarketSource;
  PostMarketChange? regularMarketChangePercent;
  PostMarketChange? regularMarketChange;
  int? regularMarketTime;
  MarketCap? priceHint;
  PostMarketChange? regularMarketPrice;
  PostMarketChange? regularMarketDayHigh;
  PostMarketChange? regularMarketDayLow;
  MarketCap? regularMarketVolume;
  AverageDailyVolume10Day? averageDailyVolume10Day;
  AverageDailyVolume10Day? averageDailyVolume3Month;
  PostMarketChange? regularMarketPreviousClose;
  String? regularMarketSource;
  PostMarketChange? regularMarketOpen;
  AverageDailyVolume10Day? strikePrice;
  AverageDailyVolume10Day? openInterest;
  String? exchange;
  String? exchangeName;
  int? exchangeDataDelayedBy;
  String? marketState;
  String? quoteType;
  String? symbol;
  dynamic underlyingSymbol;
  String? shortName;
  String? longName;
  String? currency;
  String? quoteSourceName;
  String? currencySymbol;
  dynamic fromCurrency;
  dynamic toCurrency;
  dynamic lastMarket;
  AverageDailyVolume10Day? volume24Hr;
  AverageDailyVolume10Day? volumeAllCurrencies;
  AverageDailyVolume10Day? circulatingSupply;
  MarketCap? marketCap;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    maxAge: json["maxAge"]??0,
    preMarketChangePercent:json["preMarketChangePercent"]!=null?PostMarketChange.fromJson(json["preMarketChangePercent"]):null,
    preMarketChange:json["preMarketChange"]!=null? PostMarketChange.fromJson(json["preMarketChange"]):null,
    preMarketTime: json["preMarketTime"]??0,
    preMarketPrice:json["preMarketPrice"]!=null? PostMarketChange.fromJson(json["preMarketPrice"]):null,
    preMarketSource: json["preMarketSource"]??"",
    postMarketChangePercent:json["postMarketChangePercent"]!=null? PostMarketChange.fromJson(json["postMarketChangePercent"]):null,
    postMarketChange: json["postMarketChange"]!=null?PostMarketChange.fromJson(json["postMarketChange"]):null,
    postMarketTime: json["postMarketTime"]??0,
    postMarketPrice:json["postMarketPrice"]!=null? PostMarketChange.fromJson(json["postMarketPrice"]):null,
    postMarketSource: json["postMarketSource"]??"",
    regularMarketChangePercent:json["regularMarketChangePercent"]!=null? PostMarketChange.fromJson(json["regularMarketChangePercent"]):null,
    regularMarketChange:json["regularMarketChange"]!=null? PostMarketChange.fromJson(json["regularMarketChange"]):null,
    regularMarketTime: json["regularMarketTime"] ??0,
    priceHint: json["priceHint"]!=null?MarketCap.fromJson(json["priceHint"]):null,
    regularMarketPrice:json["regularMarketPrice"]!=null? PostMarketChange.fromJson(json["regularMarketPrice"]):null,
    regularMarketDayHigh:json["regularMarketDayHigh"]!=null? PostMarketChange.fromJson(json["regularMarketDayHigh"]):null,
    regularMarketDayLow:json["regularMarketDayLow"]!=null? PostMarketChange.fromJson(json["regularMarketDayLow"]):null,
    regularMarketVolume:json["regularMarketVolume"]!=null? MarketCap.fromJson(json["regularMarketVolume"]):null,
    averageDailyVolume10Day:json["averageDailyVolume10Day"]!=null? AverageDailyVolume10Day.fromJson(json["averageDailyVolume10Day"]):null,
    averageDailyVolume3Month:json["averageDailyVolume3Month"]!=null? AverageDailyVolume10Day.fromJson(json["averageDailyVolume3Month"]):null,
    regularMarketPreviousClose:json["regularMarketPreviousClose"]!=null? PostMarketChange.fromJson(json["regularMarketPreviousClose"]):null,
    regularMarketSource: json["regularMarketSource"]??"",
    regularMarketOpen:json["regularMarketOpen"]!=null? PostMarketChange.fromJson(json["regularMarketOpen"]):null,
    strikePrice:json["strikePrice"]!=null? AverageDailyVolume10Day.fromJson(json["strikePrice"]):null,
    openInterest:json["openInterest"]!=null? AverageDailyVolume10Day.fromJson(json["openInterest"]):null,
    exchange: json["exchange"]??"",
    exchangeName: json["exchangeName"]??"",
    exchangeDataDelayedBy: json["exchangeDataDelayedBy"]??0,
    marketState: json["marketState"]??"",
    quoteType: json["quoteType"]??"",
    symbol: json["symbol"]??"",
    underlyingSymbol: json["underlyingSymbol"]??"",
    shortName: json["shortName"]??"",
    longName: json["longName"]??"",
    currency: json["currency"]??"",
    quoteSourceName: json["quoteSourceName"]??"",
    currencySymbol: json["currencySymbol"]??"",
    fromCurrency: json["fromCurrency"]??"",
    toCurrency: json["toCurrency"]??"",
    lastMarket: json["lastMarket"]??"",
    volume24Hr:json["volume24Hr"]!=null? AverageDailyVolume10Day.fromJson(json["volume24Hr"]):null,
    volumeAllCurrencies:json["volumeAllCurrencies"]!=null? AverageDailyVolume10Day.fromJson(json["volumeAllCurrencies"]):null,
    circulatingSupply:json["circulatingSupply"]!=null? AverageDailyVolume10Day.fromJson(json["circulatingSupply"]):null,
    marketCap:json["marketCap"]!=null? MarketCap.fromJson(json["marketCap"]):null,
  );

  Map<String, dynamic> toJson() => {
    "maxAge": maxAge,
    "preMarketChangePercent": preMarketChangePercent!.toJson(),
    "preMarketChange": preMarketChange!.toJson(),
    "preMarketTime": preMarketTime,
    "preMarketPrice": preMarketPrice!.toJson(),
    "preMarketSource": preMarketSource,
    "postMarketChangePercent": postMarketChangePercent!.toJson(),
    "postMarketChange": postMarketChange!.toJson(),
    "postMarketTime": postMarketTime,
    "postMarketPrice": postMarketPrice!.toJson(),
    "postMarketSource": postMarketSource,
    "regularMarketChangePercent": regularMarketChangePercent!.toJson(),
    "regularMarketChange": regularMarketChange!.toJson(),
    "regularMarketTime": regularMarketTime,
    "priceHint": priceHint!.toJson(),
    "regularMarketPrice": regularMarketPrice!.toJson(),
    "regularMarketDayHigh": regularMarketDayHigh!.toJson(),
    "regularMarketDayLow": regularMarketDayLow!.toJson(),
    "regularMarketVolume": regularMarketVolume!.toJson(),
    "averageDailyVolume10Day": averageDailyVolume10Day!.toJson(),
    "averageDailyVolume3Month": averageDailyVolume3Month!.toJson(),
    "regularMarketPreviousClose": regularMarketPreviousClose!.toJson(),
    "regularMarketSource": regularMarketSource,
    "regularMarketOpen": regularMarketOpen!.toJson(),
    "strikePrice": strikePrice!.toJson(),
    "openInterest": openInterest!.toJson(),
    "exchange": exchange,
    "exchangeName": exchangeName,
    "exchangeDataDelayedBy": exchangeDataDelayedBy,
    "marketState": marketState,
    "quoteType": quoteType,
    "symbol": symbol,
    "underlyingSymbol": underlyingSymbol,
    "shortName": shortName,
    "longName": longName,
    "currency": currency,
    "quoteSourceName": quoteSourceName,
    "currencySymbol": currencySymbol,
    "fromCurrency": fromCurrency,
    "toCurrency": toCurrency,
    "lastMarket": lastMarket,
    "volume24Hr": volume24Hr!.toJson(),
    "volumeAllCurrencies": volumeAllCurrencies!.toJson(),
    "circulatingSupply": circulatingSupply!.toJson(),
    "marketCap": marketCap!.toJson(),
  };
}

class AverageDailyVolume10Day {
  AverageDailyVolume10Day();

  factory AverageDailyVolume10Day.fromJson(Map<String, dynamic> json) => AverageDailyVolume10Day(
  );

  Map<String, dynamic> toJson() => {
  };
}

class PostMarketChange {
  PostMarketChange({
    this.raw,
    this.fmt,
  });

  double? raw;
  String? fmt;

  factory PostMarketChange.fromJson(Map<String, dynamic> json) => PostMarketChange(
    raw: json["raw"] ?? 0.0,
    fmt: json["fmt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "fmt": fmt,
  };
}
