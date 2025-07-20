
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // entre 0.0 y 10.0
  final double maxRating;
  final double starSize;
  final Color color;
  final Color backgroundColor;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 10.0,
    this.starSize = 24.0,
    this.color = Colors.amber,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final ratingOutOf5 = (rating / maxRating) * 5;
    final fullStars = ratingOutOf5.floor();
    final hasHalfStar = (ratingOutOf5 - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < fullStars; i++)
          Icon(Icons.star, color: color, size: starSize),
        if (hasHalfStar) Icon(Icons.star_half, color: color, size: starSize),
        for (var i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: backgroundColor, size: starSize),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(fontSize: starSize * 0.7),
        ),
      ],
    );
  }
}