// To parse this JSON data, do
//
//     final symbolResponce = symbolResponceFromJson(jsonString);

import 'dart:convert';

SymbolResponce symbolResponceFromJson(String str) => SymbolResponce.fromJson(json.decode(str));

String symbolResponceToJson(SymbolResponce data) => json.encode(data.toJson());

class SymbolResponce {
  SymbolResponce({
    this.finance,
  });

  Finance? finance;

  factory SymbolResponce.fromJson(Map<String, dynamic> json) => SymbolResponce(
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

  List<Result>? result;
  dynamic error;

  factory Finance.fromJson(Map<String, dynamic> json) => Finance(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "error": error,
  };
}

class Result {
  Result({
    this.count,
    this.quotes,
    this.jobTimestamp,
    this.startInterval,
  });

  int? count;
  List<Quote>? quotes;
  int? jobTimestamp;
  int? startInterval;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    count: json["count"],
    quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
    jobTimestamp: json["jobTimestamp"],
    startInterval: json["startInterval"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "quotes": List<dynamic>.from(quotes!.map((x) => x.toJson())),
    "jobTimestamp": jobTimestamp,
    "startInterval": startInterval,
  };
}

class Quote {
  Quote({
    this.symbol,
  });

  String? symbol;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
  };
}
