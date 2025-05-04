import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/sherpout_image.dart';
import 'package:sherpoutmobile/common/dto/image_dto.dart';

class ExerciseCover extends StatelessWidget {
  final ImageDto? cover;

  const ExerciseCover({
    super.key,
    required this.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
          child: SizedBox(
              width: 72,
              height: 72,
              child: cover == null
                  ? const Center(child: Icon(Icons.image, color: Colors.red))
                  : SherpoutImage(image: cover!)),
        ),
      ],
    );
  }
}
