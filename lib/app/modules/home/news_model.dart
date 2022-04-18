
import 'dart:convert';

NewsResponce newsResponceFromJson(String str) => NewsResponce.fromJson(json.decode(str));

String newsResponceToJson(NewsResponce data) => json.encode(data.toJson());

class NewsResponce {
  NewsResponce({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory NewsResponce.fromJson(Map<String, dynamic> json) => NewsResponce(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.stocksNews,
    this.cryptoNews,
  });

  List<StocksNew>? stocksNews;
  List<dynamic>? cryptoNews;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stocksNews:json["stocks_news"]!=null? List<StocksNew>.from(json["stocks_news"].map((x) => StocksNew.fromJson(x))):null,
    cryptoNews:json["crypto_news"]!=null? List<dynamic>.from(json["crypto_news"].map((x) => x)):null,
  );

  Map<String, dynamic> toJson() => {
    "stocks_news": List<dynamic>.from(stocksNews!.map((x) => x.toJson())),
    "crypto_news": List<dynamic>.from(cryptoNews!.map((x) => x)),
  };
}

class StocksNew {
  StocksNew({
    this.id,
    this.newsId,
    this.title,
    this.description,
    this.url,
    this.img_url,
    this.tickers,
    this.tags,
    this.source,
    this.publishedDate,
  });

  String? id;
  String? newsId;
  String? title;
  String? description;
  String? url;
  String? img_url;
  String? tickers;
  String? tags;
  String? source;
  String? publishedDate;

  factory StocksNew.fromJson(Map<String, dynamic> json) => StocksNew(
    id: json["id"],
    newsId: json["news_id"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    img_url: json["img_url"],
    tickers: json["tickers"],
    tags: json["tags"],
    source: json["source"],
    publishedDate: json["publishedDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "news_id": newsId,
    "title": title,
    "description": description,
    "url": url,
    "img_url": img_url,
    "tickers": tickers,
    "tags": tags,
    "source": source,
    "publishedDate": publishedDate,
  };
}
