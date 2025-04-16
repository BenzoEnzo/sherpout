import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Value',
              prefixIcon: Icon(Icons.search, color: Colors.blue),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.blue.shade100, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
            ),
          ),
    );
  }
}