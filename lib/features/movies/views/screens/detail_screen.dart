import 'package:flutter/material.dart';
import '../../data/models/movie_detail_model.dart';
import '../widgets/movie_detail_view.dart';

MovieDetailModel testDetailData = MovieDetailModel.fromMap({
    "Title": "Inception",
    "Year": "2010",
    "Rated": "PG-13",
    "Released": "16 Jul 2010",
    "Runtime": "148 min",
    "Genre": "Action, Adventure, Sci-Fi",
    "Director": "Christopher Nolan",
    "Writer": "Christopher Nolan",
    "Actors": "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page",
    "Plot": "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster.",
    "Language": "English, Japanese, French",
    "Country": "United States, United Kingdom",
    "Awards": "Won 4 Oscars. 159 wins & 220 nominations total",
    "Poster": "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg",
    "Ratings": [
        {
            "Source": "Internet Movie Database",
            "Value": "8.8/10"
        },
        {
            "Source": "Rotten Tomatoes",
            "Value": "87%"
        },
        {
            "Source": "Metacritic",
            "Value": "74/100"
        }
    ],
    "Metascore": "74",
    "imdbRating": "8.8",
    "imdbVotes": "2,705,756",
    "imdbID": "tt1375666",
    "Type": "movie",
    "DVD": "N/A",
    "BoxOffice": "\$292,587,330",
    "Production": "N/A",
    "Website": "N/A",
    "Response": "True"
});

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: fetch movie detail by id
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail'),
      ),
      body: MovieDetailView(movie: testDetailData),
    );
  }
}
