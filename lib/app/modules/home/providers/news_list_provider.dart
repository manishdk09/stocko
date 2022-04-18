import 'package:dio/dio.dart';
import '../../../utils/constants/url_constant.dart';
import '../news_model.dart';

class NewsListProvider{
  Future<NewsResponce> getNews() async{
    BaseOptions options = BaseOptions(
      baseUrl: DUrl.BASE_URL2,
    );
    Dio _dio = Dio(options);
    var responseJson;
    late NewsResponce _responce=new NewsResponce();
    try {
      final response = await _dio.get(DUrl.getNews);
      print(response);
      responseJson = response.data;
      if(responseJson!=null){
        _responce = NewsResponce.fromJson(responseJson);
      }
      return _responce;
    } on DioError catch (e) {
      print(e.message);
    }
    return _responce;
  }

}