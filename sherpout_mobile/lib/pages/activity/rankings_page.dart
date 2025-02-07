import 'package:flutter/material.dart';

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rankings")),
      body: Center(child: Text("This is the Rankings page")),
    );
  }
}