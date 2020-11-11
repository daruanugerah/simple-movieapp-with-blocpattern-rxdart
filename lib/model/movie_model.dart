class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String voteAverage;
  final String poster;
  final String backdrop;
  final String date;

  MovieModel(
      {this.id,
      this.title,
      this.overview,
      this.voteAverage,
      this.poster,
      this.backdrop,
      this.date});

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        overview = json["overview"],
        voteAverage = json["vote_average"].toString(),
        poster = json["poster_path"],
        backdrop = json["backdrop_path"],
        date = json["release_date"];
}

class MovieResponse {
  final List<MovieModel> movies;
  final String error;

  MovieResponse({this.movies, this.error});

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((e) => new MovieModel.fromJson(e))
            .toList(),
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
