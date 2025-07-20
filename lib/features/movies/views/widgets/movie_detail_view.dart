import 'package:flutter/material.dart';

import '../../data/models/movie_detail_model.dart';
import 'star_rating.dart';

class MovieDetailView extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movie.poster.isNotEmpty)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${movie.title} (${movie.year})",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Chip(
                label: Text(
                  movie.type.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepPurple,
              ),
            ],
          ),
          StarRating(rating: double.tryParse(movie.imdbRating) ?? 0.0),
          Text("🕒 Runtime: ${movie.runtime}"),
          const SizedBox(height: 8),
          Text(movie.plot, style: Theme.of(context).textTheme.bodyMedium),

          const SizedBox(height: 8),
          Divider(),
          const SizedBox(height: 8),

          if (movie.awards.isNotEmpty) Text("🏆 Awards: ${movie.awards}"),
          if (movie.released.isNotEmpty) Text("📅 Released: ${movie.released}"),
          if (movie.director.isNotEmpty) Text("🎬 Director: ${movie.director}"),
          if (movie.writer.isNotEmpty) Text("✍️ Writer: ${movie.writer}"),
          if (movie.actors.isNotEmpty) Text("🎭 Actors: ${movie.actors}"),
          if (movie.language.isNotEmpty) Text("🌎 Language: ${movie.language}"),
          if (movie.boxOffice.isNotEmpty)
            Text("📦 Box Office: ${movie.boxOffice}"),

          // Ratings
          if (movie.ratings.isNotEmpty) ...[
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),

            Text("Ratings", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  movie.ratings.map((r) {
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
    );
  }
}
