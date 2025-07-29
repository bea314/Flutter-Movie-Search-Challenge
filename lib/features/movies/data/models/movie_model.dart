import 'dart:convert';

import '../../logic/enums/media_type.dart';

class MovieModel {
    final String title;
    final String year;
    final String imdbId;
    final MediaType type;
    final String poster;

    MovieModel({
        required this.title,
        required this.year,
        required this.imdbId,
        required this.type,
        required this.poster,
    });

    MovieModel copyWith({
        String? title,
        String? year,
        String? imdbId,
        MediaType? type,
        String? poster,
    }) => 
        MovieModel(
            title: title ?? this.title,
            year: year ?? this.year,
            imdbId: imdbId ?? this.imdbId,
            type: type ?? this.type,
            poster: poster ?? this.poster,
        );

    factory MovieModel.fromJson(String str) => MovieModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: MediaTypeExtension.fromString(json['Type'] as String? ?? ''),
        poster: json["Poster"],
    );

    Map<String, dynamic> toMap() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        "Type": type.value,
        "Poster": poster,
    };
}
