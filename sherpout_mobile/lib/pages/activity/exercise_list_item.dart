import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          Container(
            width: 72,
            decoration: BoxDecoration(
              color: const Color(0xffC94935),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                "HARD",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Container(
              width: 72,
              height: 72,
              color: Colors.black,
            ),
          ),
        ],),
        SizedBox(width: 16),
        Expanded(
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Exercise name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              Text("Muscle 1, Muscle 2", style: TextStyle(fontSize: 18)),
              Text("Muscle 3", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Icon(Icons.chevron_right)
      ],
    );
  }
}