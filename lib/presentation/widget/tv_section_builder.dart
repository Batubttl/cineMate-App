import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/widget/media_section.dart';
import 'package:flutter/material.dart';

class TVSectionBuilder extends StatelessWidget {
  final List<MovieResults>? popularTvShows;
  final List<MovieResults>? trendingTvShows;
  final List<MovieResults>? topRatedTvShows;

  const TVSectionBuilder({
    super.key,
    required this.popularTvShows,
    required this.trendingTvShows,
    required this.topRatedTvShows,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trendingTvShows != null && trendingTvShows!.isNotEmpty)
            MediaSection(
              title: AppString.trendingTvShows,
              items: trendingTvShows!,
              mediaType: MediaType.tv,
            ),
          const SizedBox(height: 20),
          if (popularTvShows != null && popularTvShows!.isNotEmpty)
            MediaSection(
              title: AppString.popularTvShows,
              items: popularTvShows!,
              mediaType: MediaType.tv,
            ),
          const SizedBox(height: 20),
          if (topRatedTvShows != null && topRatedTvShows!.isNotEmpty)
            MediaSection(
              title: AppString.topRatedTvShows,
              items: topRatedTvShows!,
              mediaType: MediaType.tv,
            ),
        ],
      ),
    );
  }
}
