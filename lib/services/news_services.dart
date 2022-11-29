

import 'package:dio/dio.dart';
import 'package:project_start/api.dart';
import 'package:project_start/models/news.dart';

class NewsService{

  static Future<List<News>> getQueryNews(String query) async{
    final dio=Dio();
    try{
      final response= await dio.get(Api.searchNewsApi,
          queryParameters: {
            'q':query,
            'lang':'en'
          },
          options: Options(
              headers: {
                'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
                'X-RapidAPI-Key': '938c715c4emsh0a192f110f34f2cp15e067jsnb8ccd71502cd'

              }
          )
      );
      final data= (response.data['articles']as List).map((news) => News.fromJson(news)).toList();
      return data;
    }on DioError catch(err){
      return [];
    }
  }



static Future getNews() async{
  final dio=Dio();
  try{
    await Future.delayed(Duration(seconds: 4));
    final response= await dio.get(Api.searchNewsApi,
    queryParameters: {
      'q':'nasa',
      'lang':'en'
    },
    options: Options(
        headers: {
          'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
          'X-RapidAPI-Key': '938c715c4emsh0a192f110f34f2cp15e067jsnb8ccd71502cd'

        }
    )
    );
    print(response.data);

  }on DioError catch(err){

  }

}
}