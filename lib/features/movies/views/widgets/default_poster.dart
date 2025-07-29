import 'package:flutter/material.dart';

class PosterImage extends StatelessWidget {
  final String id;
  final String? url;

  const PosterImage(this.id, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return const DefaultPoster();
    return Hero(
      tag: id,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url!,
          height: 400,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (_, __, ___) => const DefaultPoster(),
        ),
      ),
    );
  }
}

class DefaultPoster extends StatelessWidget {
  const DefaultPoster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.image_not_supported_outlined, size: 200,),);
  }
}