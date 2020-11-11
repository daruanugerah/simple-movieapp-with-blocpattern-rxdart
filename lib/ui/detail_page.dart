import 'package:adsflutter/model/movie_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final MovieModel movie;

  DetailPage({Key key, @required this.movie}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(movie);
}

class _DetailPageState extends State<DetailPage> {
  final MovieModel movie;

  _DetailPageState(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/original" + movie.backdrop),
                  fit: BoxFit.cover,
                )),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.transparent.withOpacity(0)
                  ],
                )),
              ),
              Positioned(
                  top: 30,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  )),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 10,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    movie.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Text(
                        movie.voteAverage + "/10",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 30,
                      ),
                      Text(
                        movie.date,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "OVERVIEW",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              movie.overview,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
