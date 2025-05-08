import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/sherpout_image.dart';
import 'package:sherpoutmobile/common/dto/image_dto.dart';

class ExerciseMediaCarousel extends StatefulWidget {
  final Set<ImageDto> images;

  const ExerciseMediaCarousel({super.key, required this.images});

  @override
  State<ExerciseMediaCarousel> createState() => _ExerciseMediaCarouselState();
}

class _ExerciseMediaCarouselState extends State<ExerciseMediaCarousel> {

  late CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselView(
        controller: carouselController,
        itemExtent: 300,
        onTap: (index) => showDialog(
          context: context,
          builder: (_) => _showDialog(index),
        ),
        children:
          widget.images.map((image) {
            return SherpoutImage(image: image);
          }).toList(),
    );
  }

  Dialog _showDialog(int index) {
    print("jebe twoja stara");
    return Dialog(
      backgroundColor: Colors.grey,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(
            child: InteractiveViewer(
                child: SherpoutImage(image: widget.images.elementAt(index))
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}