import 'dart:convert';

SearchResponce searchResponceFromJson(String str) => SearchResponce.fromJson(json.decode(str));

String searchResponceToJson(SearchResponce data) => json.encode(data.toJson());

class SearchResponce {
  SearchResponce({
    this.explains,
    this.count,
    this.quotes,
    this.news,
    this.nav,
    this.lists,
    this.researchReports,
    this.screenerFieldResults,
    this.culturalAssets,
    this.totalTime,
    this.timeTakenForQuotes,
    this.timeTakenForNews,
    this.timeTakenForAlgowatchlist,
    this.timeTakenForPredefinedScreener,
    this.timeTakenForCrunchbase,
    this.timeTakenForNav,
    this.timeTakenForResearchReports,
    this.timeTakenForScreenerField,
    this.timeTakenForCulturalAssets,
  });

  List<dynamic>? explains;
  int? count;
  List<Quote>? quotes;
  List<dynamic>? news;
  List<dynamic>? nav;
  List<dynamic>? lists;
  List<dynamic>? researchReports;
  List<dynamic>? screenerFieldResults;
  List<dynamic>? culturalAssets;
  int? totalTime;
  int? timeTakenForQuotes;
  int? timeTakenForNews;
  int? timeTakenForAlgowatchlist;
  int? timeTakenForPredefinedScreener;
  int? timeTakenForCrunchbase;
  int? timeTakenForNav;
  int? timeTakenForResearchReports;
  int? timeTakenForScreenerField;
  int? timeTakenForCulturalAssets;

  factory SearchResponce.fromJson(Map<String, dynamic> json) => SearchResponce(
    explains:json["explains"]??List<dynamic>.from(json["explains"].map((x) => x)),
    count: json["count"]?? 0,
    quotes:json["quotes"] !=null? List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))):[],
    news:json["news"]?? List<dynamic>.from(json["news"].map((x) => x)),
    nav:json["nav"]?? List<dynamic>.from(json["nav"].map((x) => x)),
    lists:json["lists"]?? List<dynamic>.from(json["lists"].map((x) => x)),
    researchReports:json["researchReports"]?? List<dynamic>.from(json["researchReports"].map((x) => x)),
    screenerFieldResults:json["screenerFieldResults"]?? List<dynamic>.from(json["screenerFieldResults"].map((x) => x)),
    culturalAssets:json["culturalAssets"]!=null? List<dynamic>.from(json["culturalAssets"].map((x) => x)):null,
    totalTime: json["totalTime"]?? 0,
    timeTakenForQuotes: json["timeTakenForQuotes"] ?? 0,
    timeTakenForNews: json["timeTakenForNews"]?? 0,
    timeTakenForAlgowatchlist: json["timeTakenForAlgowatchlist"]?? 0,
    timeTakenForPredefinedScreener: json["timeTakenForPredefinedScreener"]?? 0,
    timeTakenForCrunchbase: json["timeTakenForCrunchbase"]?? 0,
    timeTakenForNav: json["timeTakenForNav"]?? 0,
    timeTakenForResearchReports: json["timeTakenForResearchReports"]?? 0,
    timeTakenForScreenerField: json["timeTakenForScreenerField"]?? 0,
    timeTakenForCulturalAssets: json["timeTakenForCulturalAssets"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "explains": List<dynamic>.from(explains!.map((x) => x)),
    "count": count,
    "quotes": List<dynamic>.from(quotes!.map((x) => x.toJson())),
    "news": List<dynamic>.from(news!.map((x) => x)),
    "nav": List<dynamic>.from(nav!.map((x) => x)),
    "lists": List<dynamic>.from(lists!.map((x) => x)),
    "researchReports": List<dynamic>.from(researchReports!.map((x) => x)),
    "screenerFieldResults": List<dynamic>.from(screenerFieldResults!.map((x) => x)),
    "culturalAssets": List<dynamic>.from(culturalAssets!.map((x) => x)),
    "totalTime": totalTime,
    "timeTakenForQuotes": timeTakenForQuotes,
    "timeTakenForNews": timeTakenForNews,
    "timeTakenForAlgowatchlist": timeTakenForAlgowatchlist,
    "timeTakenForPredefinedScreener": timeTakenForPredefinedScreener,
    "timeTakenForCrunchbase": timeTakenForCrunchbase,
    "timeTakenForNav": timeTakenForNav,
    "timeTakenForResearchReports": timeTakenForResearchReports,
    "timeTakenForScreenerField": timeTakenForScreenerField,
    "timeTakenForCulturalAssets": timeTakenForCulturalAssets,
  };
}

class Quote {
  Quote({
    this.exchange,
    this.shortname,
    this.quoteType,
    this.symbol,
    this.index,
    this.score,
    this.typeDisp,
    this.longname,
    this.exchDisp,
    this.isYahooFinance,
  });

  String? exchange;
  String? shortname;
  String? quoteType;
  String? symbol;
  String? index;
  double? score;
  String? typeDisp;
  String? longname;
  String? exchDisp;
  bool? isYahooFinance;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    exchange: json["exchange"] ?? "",
    shortname: json["shortname"]?? "",
    quoteType: json["quoteType"]?? "",
    symbol: json["symbol"]?? "",
    index: json["index"]?? "",
    score: json["score"]?? 0.0,
    typeDisp: json["typeDisp"]?? "",
    longname: json["longname"]?? "",
    exchDisp: json["exchDisp"]?? "",
    isYahooFinance: json["isYahooFinance"]?? false,
  );

  Map<String, dynamic> toJson() => {
    "exchange": exchange,
    "shortname": shortname,
    "quoteType": quoteType,
    "symbol": symbol,
    "index": index,
    "score": score,
    "typeDisp": typeDisp,
    "longname": longname == null ? null : longname,
    "exchDisp": exchDisp,
    "isYahooFinance": isYahooFinance,
  };
}
