import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_difficulty.dart';
import 'package:sherpoutmobile/services/image_service.dart';
import 'package:sherpoutmobile/common/dto/image_dto.dart';
import 'exercise_difficulty_label.dart';

class ExerciseCover extends StatelessWidget {
  final ExerciseDifficulty difficulty;
  final String objectName;

  const ExerciseCover({
    super.key,
    required this.difficulty,
    required this.objectName,
  });

  @override
  Widget build(BuildContext context) {
    final ImageService imageService = GetIt.instance.get<ImageService>();
    return Column(
      children: [
        ExerciseDifficultyLabel(difficulty: difficulty),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
          child: SizedBox(
            width: 72,
            height: 72,
            child: FutureBuilder<ImageDto>(
              future: imageService.fetchImage(objectName),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Icon(Icons.error, color: Colors.red));
                }
                return CachedNetworkImage(
                  imageUrl: snapshot.data!.imagePath,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
