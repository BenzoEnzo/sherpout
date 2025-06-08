import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hint;

  const SearchInput({super.key, required this.onChanged, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.search, color: AppColors.secondary),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.secondary, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.secondary, width: 2),
              ),
            ),
          ),
    );
  }
}
