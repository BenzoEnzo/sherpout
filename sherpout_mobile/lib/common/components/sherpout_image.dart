// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/image_dto.dart';

import '../../services/image_service.dart';
import '../dto/image_url_dto.dart';
import '../theme/app_colors.dart';

class SherpoutImage extends StatelessWidget {
  final ImageDto image;

  const SherpoutImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final ImageService imageService = GetIt.instance.get<ImageService>();

    return FutureBuilder<ImageUrlDto>(
      future: imageService.fetchImageUrl(image.name),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Icon(Icons.image, color: AppColors.secondary));
        }
        return CachedNetworkImage(
          imageUrl: snapshot.data!.url,
          fit: BoxFit.cover,
          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        );
      },
    );
  }

}