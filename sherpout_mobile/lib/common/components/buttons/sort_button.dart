import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

class SortButton extends StatefulWidget {
  final List<String> labels;
  final ValueChanged<int>? onSelected;

  const SortButton({
    super.key,
    required this.labels,
    this.onSelected,
  });

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.labels.length, (i) => i == 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ToggleButtons(
          borderRadius: BorderRadius.circular(30),
          selectedColor: Colors.white,
          color: AppColors.primary,
          fillColor: AppColors.primary,
          borderColor: AppColors.secondary,
          selectedBorderColor: AppColors.secondary,
          constraints: BoxConstraints.expand(
            width: constraints.maxWidth / widget.labels.length - 2,
          ),
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });

            if (widget.onSelected != null) {
              widget.onSelected!(index);
            }
          },
          children: widget.labels
              .map(
                (label) => Text(
              label,
              style: AppTypography.buttonMedium,
            ),
          )
              .toList(),
        );
      },
    );
  }
}
