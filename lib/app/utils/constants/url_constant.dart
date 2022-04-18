abstract class DUrl {
  DUrl._();

  // urls
  static const BASE_URL2="https://api.mdtechnolab.com/";
  static const BASE_URL3="https://mdtechnolab.com/";
  static const BASE_URL="https://query1.finance.yahoo.com/";

  // symbol provider
  static const getVersion="version";
  static const getAdsId="panel_of_admin_application/api_of_applications/stocks_ads_api";
  static const getSymbol="v1/finance/trending/US?count=15";

  // main data provider
  static const getMainData1="v7/finance/quote?formatted=true&lang=en-US&region=US&symbols=";
  static const getMainData2="&fields=symbol%2CshortName%2ClongName%2CregularMarketPrice%2CregularMarketChange%2CregularMarketChangePercent";

  // new provider
  static const getNews="v1/home/News";

}