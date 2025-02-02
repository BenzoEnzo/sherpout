import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sherpout dashboard')),
      body: Center(
        child: Text(
          'Sherpout dashboard',
          style: TextStyle(
            fontSize: 24
          ),
        )
      ),
    );
  }
}