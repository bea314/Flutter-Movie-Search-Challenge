import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  final String title;
  final String posterUrl;
  final VoidCallback onTap;
  final double? size;

  const MovieListItem({
    super.key,
    required this.title,
    required this.posterUrl,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = size ?? 150;
    final itemHeight = itemWidth * 1.5; // 2:3 aspect ratio (tipo poster vertical)
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: itemWidth,
          maxHeight: itemHeight,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: onTap,
          padding: EdgeInsets.zero,
          child: posterUrl.isNotEmpty
            ? Image.network(
              posterUrl, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported_outlined, size: 100,),
            )
            : Icon(Icons.movie,),
        ),
      ),
    );
  }
}
