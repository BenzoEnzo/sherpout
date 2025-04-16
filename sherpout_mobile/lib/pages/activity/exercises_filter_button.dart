
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExercisesFilterButton extends StatefulWidget {
  @override
  _ExercisesFilterButtonState createState() => _ExercisesFilterButtonState();
}

class _ExercisesFilterButtonState extends State<ExercisesFilterButton> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints)
    {
      return ToggleButtons(
        borderRadius: BorderRadius.circular(30),
        selectedColor: Colors.white,
        color: Colors.blue,
        fillColor: Colors.blue,
        borderColor: Colors.blue,
        selectedBorderColor: Colors.blue,
        constraints: BoxConstraints.expand(width: constraints.maxWidth / 2 - 2),
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          });
        },
        children: [
          Text('Sort by likes'),
          Text('Sort by popularity'),
        ],
      );
    });
  }
}