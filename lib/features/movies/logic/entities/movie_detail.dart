import '../../data/models/movie_detail_model.dart';

class MovieDetail {
  final String imdbId;
  final String title;
  final String? year;
  final String? plot;
  final String? poster;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? language;
  final String? country;
  final String? awards;
  final List<Rating>? ratings;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? type;
  final String? dvd;
  final String? boxOffice;
  final String? production;
  final String? website;
  final String? response;

  MovieDetail({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.plot,
    required this.poster,
    this.rated, 
    this.released, 
    this.runtime, 
    this.genre, 
    this.director, 
    this.writer, 
    this.actors, 
    this.language, 
    this.country, 
    this.awards, 
    this.ratings, 
    this.metascore, 
    this.imdbRating, 
    this.imdbVotes, 
    this.type, 
    this.dvd, 
    this.boxOffice, 
    this.production, 
    this.website, 
    this.response,
  });
}

