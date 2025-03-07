import 'dart:ui';

import 'package:cinemate_app/core/constant/api_constant.dart';
import 'package:cinemate_app/core/enum/image_size.dart';

extension ImagePathExtension on String? {
  String toImageUrl({required ImageSize size}) {
    if (this == null || this!.isEmpty) return '';
    return '${ApiConstant.imageBaseUrl}/${size.value}$this';
  }

  String toPosterUrl() {
    return toImageUrl(size: ImageSize.w500);
  }

  String toBackdropUrl() {
    return toImageUrl(size: ImageSize.original);
  }

  String toProfileUrl() {
    return toImageUrl(size: ImageSize.w185);
  }
}
