import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';

class MediaSection extends StatelessWidget {
  final String title;
  final List<MovieResults> items;
  final MediaType mediaType;

  const MediaSection({
    super.key,
    required this.title,
    required this.items,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 8.0,
                  right: index == items.length - 1 ? 16.0 : 8.0,
                ),
                child: MovieCard(
                  movie: items[index],
                  isCarouselView: false,
                  mediaType: mediaType,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
