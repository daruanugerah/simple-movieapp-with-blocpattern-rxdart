import 'package:adsflutter/bloc/movie_bloc.dart';
import 'package:adsflutter/model/movie_model.dart';
import 'package:adsflutter/ui/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    movieBloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: movieBloc.allMovie,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.data.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 4,
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error: $error"),
        ],
      ),
    );
  }

  Widget _buildListView(MovieResponse data) {
    List<MovieModel> movies = data.movies;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(movie: movies[index]),
              ),
            );
          },
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w780" +
                                  movies[index].poster),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        movies[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                          ),
                          Text(
                            movies[index].date,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            movies[index].voteAverage + "/10",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
