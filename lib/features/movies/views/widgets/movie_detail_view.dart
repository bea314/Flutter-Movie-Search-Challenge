import 'package:flutter/material.dart';

import '../../logic/enums/media_type.dart';
import '../../data/models/movie_detail_model.dart';
import 'default_poster.dart';
import 'star_rating.dart';

class MovieDetailView extends StatelessWidget {
  final String id;
  final MovieDetailModel movie;
  final String? poster;

  const MovieDetailView({
    super.key,
    required this.id,
    required this.movie,
    this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: PosterImage(id, poster ?? movie.poster)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "${movie.title} (${movie.year})",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Chip(
                  label: Text(
                    (movie.type?.value ?? 'unknown').toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.deepPurple,
                ),
              ],
            ),
            if (movie.imdbRating != null)
              StarRating(rating: double.tryParse(movie.imdbRating!) ?? 0.0),
            Text("🕒 Runtime: ${movie.runtime ?? 'Unknown'}"),
            const SizedBox(height: 8),
            Text(
              movie.plot ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),

            if (movie.awards != null && movie.awards!.isNotEmpty)
              Text("🏆 Awards: ${movie.awards}"),
            if (movie.released != null && movie.released!.isNotEmpty)
              Text("📅 Released: ${movie.released}"),
            if (movie.director != null && movie.director!.isNotEmpty)
              Text("🎬 Director: ${movie.director}"),
            if (movie.writer != null && movie.writer!.isNotEmpty)
              Text("✍️ Writer: ${movie.writer}"),
            if (movie.actors != null && movie.actors!.isNotEmpty)
              Text("🎭 Actors: ${movie.actors}"),
            if (movie.language != null && movie.language!.isNotEmpty)
              Text("🌎 Language: ${movie.language}"),
            if (movie.boxOffice != null && movie.boxOffice!.isNotEmpty)
              Text("📦 Box Office: ${movie.boxOffice}"),

            // Ratings
            if (movie.ratings != null && movie.ratings!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Divider(),
              const SizedBox(height: 8),

              Text("Ratings", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    movie.ratings!.map((r) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 8),
                            Text("${r.source}: ${r.value}"),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
