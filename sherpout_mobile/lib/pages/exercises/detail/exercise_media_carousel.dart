import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseMediaCarousel extends StatefulWidget {
  const ExerciseMediaCarousel({super.key});

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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Container(
              width: 72,
              height: 72,
              color: Colors.red,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Container(
              width: 72,
              height: 72,
              color: Colors.blue,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Container(
              width: 72,
              height: 72,
              color: Colors.green,
            ),
          ),
        ]);
  }

}