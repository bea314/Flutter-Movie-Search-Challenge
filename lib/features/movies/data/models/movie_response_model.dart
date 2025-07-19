import 'dart:convert';

import 'movie_model.dart';

class MovieResponseModel {
    final List<MovieModel> movies;
    final String totalResults;
    final String response;
    final String? error; 

    MovieResponseModel({
        required this.movies,
        required this.totalResults,
        required this.response,
        this.error,
    });

    MovieResponseModel copyWith({
        List<MovieModel>? movies,
        String? totalResults,
        String? response,
        String? error,
    }) => 
        MovieResponseModel(
            movies: movies ?? this.movies,
            totalResults: totalResults ?? this.totalResults,
            response: response ?? this.response,
            error: error ?? this.error,
        );

    factory MovieResponseModel.fromJson(String str) => MovieResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieResponseModel.fromMap(Map<String, dynamic> json) => MovieResponseModel(
        movies: List<MovieModel>.from(json["Search"].map((x) => MovieModel.fromMap(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
        error: json["Error"] as String?, // capture OMDb’s error message
    );

    Map<String, dynamic> toMap() => {
        "Search": List<dynamic>.from(movies.map((x) => x.toMap())),
        "totalResults": totalResults,
        "Response": response,
        if (error != null) "Error": error,
    };
}
