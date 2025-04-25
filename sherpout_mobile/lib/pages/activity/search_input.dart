import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchExercises,
              prefixIcon: Icon(Icons.search, color: const Color(0xffADC5EB),),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: const Color(0xffADC5EB), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: const Color(0xff4B7FD2), width: 2),
              ),
            ),
          ),
    );
  }
}