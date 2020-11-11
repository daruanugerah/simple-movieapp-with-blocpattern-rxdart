import 'package:adsflutter/model/movie_model.dart';
import 'package:dio/dio.dart';

class Repository {
  final String apiKey = "24b7e91435fd3bc9c816f5179e47e906";
  final String mainUrl = "https://api.themoviedb.org/3/discover/movie";
  final Dio _dio = Dio();

  Future<MovieResponse> fetchMovieList() async {
   var params = {"api_key": apiKey, "language": "en-US"};

   try {
     Response response = await _dio.get(mainUrl, queryParameters: params);
     print(response.data);
     return MovieResponse.fromJson(response.data);
   } catch (error) {
     print('Exception occured: $error');
     return MovieResponse.withError("$error");
   }

  }
}
