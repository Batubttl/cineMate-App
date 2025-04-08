import 'package:cinemate_app/core/extension/string_extension.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/core/theme/text_styles.dart';
import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:flutter/material.dart';

class CastList extends StatelessWidget {
  final List<Cast> cast;

  const CastList({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final castMember = cast[index];
          return Container(
            width: 80,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == cast.length - 1 ? 0 : 8,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: castMember.profilePath != null
                      ? NetworkImage(castMember.profilePath!.toProfileUrl())
                      : null,
                  child: castMember.profilePath == null
                      ? const Icon(Icons.person,
                          size: 40, color: AppColors.grey)
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  castMember.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: AppTextStyles.castInfo,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
