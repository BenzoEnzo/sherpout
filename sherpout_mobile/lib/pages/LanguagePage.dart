import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                "Choose language:",
                    style: TextStyle(
                      fontSize: 24
                    )
            ),
            Text("Polish (PL)")
          ]
        ),
      ),
    );
  }
}