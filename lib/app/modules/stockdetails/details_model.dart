// To parse this JSON data, do
//
//     final detailsResponce = detailsResponceFromJson(jsonString);

import 'dart:convert';

DetailsResponce detailsResponceFromJson(String str) => DetailsResponce.fromJson(json.decode(str));

String detailsResponceToJson(DetailsResponce data) => json.encode(data.toJson());

class DetailsResponce {
  DetailsResponce({
    this.finance,
  });

  Finance? finance;

  factory DetailsResponce.fromJson(Map<String, dynamic> json) => DetailsResponce(
    finance: Finance.fromJson(json["finance"]),
  );

  Map<String, dynamic> toJson() => {
    "finance": finance!.toJson(),
  };
}

class Finance {
  Finance({
    this.result,
    this.error,
  });

  ResultReport? result;
  dynamic error;

  factory Finance.fromJson(Map<String, dynamic> json) => Finance(
    result: ResultReport.fromJson(json["result"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": result!.toJson(),
    "error": error,
  };
}

class ResultReport {
  ResultReport({
    this.symbol,
    this.instrumentInfo,
    this.reports,
    this.companySnapshot,
  });

  String? symbol;
  InstrumentInfo? instrumentInfo;
  List<Report>? reports;
  CompanySnapshot? companySnapshot;

  factory ResultReport.fromJson(Map<String, dynamic> json) => ResultReport(
    symbol: json["symbol"],
    instrumentInfo:json["instrumentInfo"]!=null? InstrumentInfo.fromJson(json["instrumentInfo"]):null,
    reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
    companySnapshot: json["companySnapshot"]!=null? CompanySnapshot.fromJson(json["companySnapshot"]):null,
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "instrumentInfo": instrumentInfo!.toJson(),
    "reports": List<dynamic>.from(reports!.map((x) => x.toJson())),
    "companySnapshot": companySnapshot!.toJson(),
  };
}

class CompanySnapshot {
  CompanySnapshot({
    this.sectorInfo,
    this.company,
    this.sector,
  });

  String? sectorInfo;
  Company? company;
  Company? sector;

  factory CompanySnapshot.fromJson(Map<String, dynamic> json) => CompanySnapshot(
    sectorInfo: json["sectorInfo"],
    company: Company.fromJson(json["company"]),
    sector: Company.fromJson(json["sector"]),
  );

  Map<String, dynamic> toJson() => {
    "sectorInfo": sectorInfo,
    "company": company!.toJson(),
    "sector": sector!.toJson(),
  };
}

class Company {
  Company({
    this.innovativeness,
    this.hiring,
    this.sustainability,
    this.insiderSentiments,
    this.earningsReports,
    this.dividends,
  });

  double? innovativeness;
  double? hiring;
  double? sustainability;
  double? insiderSentiments;
  double? earningsReports;
  double? dividends;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    innovativeness:json["innovativeness"]!=null? json["innovativeness"].toDouble() : 0.0,
    hiring:json["hiring"]!=null? json["hiring"].toDouble() : 0.0,
    sustainability:json["sustainability"]!=null? json["sustainability"].toDouble() : 0.0,
    insiderSentiments:json["insiderSentiments"]!=null?json["insiderSentiments"].toDouble() : 0.0,
    earningsReports:json["earningsReports"]!=null? json["earningsReports"].toDouble() : 0.0,
    dividends:json["dividends"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "innovativeness": innovativeness,
    "hiring": hiring,
    "sustainability": sustainability,
    "insiderSentiments": insiderSentiments,
    "earningsReports": earningsReports,
    "dividends": dividends,
  };
}

class InstrumentInfo {
  InstrumentInfo({
    this.technicalEvents,
    this.keyTechnicals,
    this.valuation,
    this.recommendation,
  });

  TechnicalEvents? technicalEvents;
  KeyTechnicals? keyTechnicals;
  Valuation? valuation;
  Recommendation? recommendation;

  factory InstrumentInfo.fromJson(Map<String, dynamic> json) => InstrumentInfo(
    technicalEvents:json["technicalEvents"]!=null? TechnicalEvents.fromJson(json["technicalEvents"]):null,
    keyTechnicals:json["keyTechnicals"]!=null? KeyTechnicals.fromJson(json["keyTechnicals"]):null,
    valuation:json["valuation"]!=null? Valuation.fromJson(json["valuation"]):null,
    recommendation:json["recommendation"]!=null? Recommendation.fromJson(json["recommendation"]):null,
  );

  Map<String, dynamic> toJson() => {
    "technicalEvents": technicalEvents!.toJson(),
    "keyTechnicals": keyTechnicals!.toJson(),
    "valuation": valuation!.toJson(),
    "recommendation": recommendation!.toJson(),
  };
}

class KeyTechnicals {
  KeyTechnicals({
    this.provider,
    this.support,
    this.resistance,
    this.stopLoss,
  });

  String? provider;
  double? support;
  double? resistance;
  double? stopLoss;

  factory KeyTechnicals.fromJson(Map<String, dynamic> json) => KeyTechnicals(
    provider: json["provider"] ?? "",
    support: json["support"].toDouble() ?? 0.0,
    resistance: json["resistance"].toDouble() ?? 0.0,
    stopLoss: json["stopLoss"].toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "provider": provider,
    "support": support,
    "resistance": resistance,
    "stopLoss": stopLoss,
  };
}

class Recommendation {
  Recommendation({
    this.targetPrice,
    this.provider,
    this.rating,
  });

  double? targetPrice;
  String? provider;
  String? rating;

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
    targetPrice: json["targetPrice"] ?? 0.0,
    provider:json["provider"] ?? "",
    rating: json["rating"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "targetPrice": targetPrice,
    "provider": provider,
    "rating": rating,
  };
}




class TechnicalEvents {
  TechnicalEvents({
    this.provider,
    this.shortTerm,
    this.midTerm,
    this.longTerm,
  });

  String? provider;
  String? shortTerm;
  String? midTerm;
  String? longTerm;

  factory TechnicalEvents.fromJson(Map<String, dynamic> json) => TechnicalEvents(
    provider: json["provider"],
    shortTerm: json["shortTerm"],
    midTerm: json["midTerm"],
    longTerm: json["longTerm"],
  );

  Map<String, dynamic> toJson() => {
    "provider": provider,
    "shortTerm": shortTerm,
    "midTerm": midTerm,
    "longTerm": longTerm,
  };
}

class Valuation {
  Valuation({
    this.color,
    this.description,
    this.discount,
    this.relativeValue,
    this.provider,
  });

  double? color;
  String? description;
  String? discount;
  String? relativeValue;
  String? provider;

  factory Valuation.fromJson(Map<String, dynamic> json) => Valuation(
    color: json["color"] ?? 0.0,
    description: json["description"]?? "",
    discount: json["discount"]?? "",
    relativeValue: json["relativeValue"]?? "",
    provider: json["provider"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "description": description,
    "discount": discount,
    "relativeValue": relativeValue,
    "provider": provider,
  };
}

class Report {
  Report({
    this.id,
    this.title,
    this.provider,
    this.publishedOn,
    this.summary,
  });

  String? id;
  String? title;
  String? provider;
  String? publishedOn;
  String? summary;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"] ?? "",
    title: json["title"]?? "",
    provider: json["provider"]?? "",
    publishedOn: json["publishedOn"]?? "",
    summary: json["summary"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "provider": provider,
    "publishedOn": publishedOn,
    "summary": summary,
  };
}

