import 'package:flutter/material.dart';

class SherpoutPage extends StatelessWidget {
  final Widget child;

  const SherpoutPage({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: child
    );
  }
  
}