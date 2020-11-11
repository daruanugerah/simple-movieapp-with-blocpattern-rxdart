import 'package:adsflutter/model/movie_model.dart';
import 'package:adsflutter/service/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final repository = Repository();
  final movieFetcher = PublishSubject<MovieResponse>();
  Stream<MovieResponse> get allMovie => movieFetcher.stream;

  fetchAllMovies() async {
    MovieResponse movieResponse = await repository.fetchMovieList();
    movieFetcher.sink.add(movieResponse);
  }

  dispose() {
    movieFetcher.close();
  }
}

final movieBloc = MovieBloc();