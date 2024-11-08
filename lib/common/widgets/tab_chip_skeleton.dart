import 'package:flutter/material.dart';

class TabChipSkeleton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final void Function(bool) onSelected;
  const TabChipSkeleton(
      {super.key,
      required this.selected,
      required this.onSelected,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final labelStyle =
        theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer);

    return FilterChip(
        showCheckmark: false,
        labelStyle: labelStyle,
        label: SizedBox(
            width: screenWidth * 0.15,
            child: AnimatedCrossFade(
                firstChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [Text(label)]),
                secondChild: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(icon, size: 16, color: labelStyle?.color),
                  const SizedBox(width: 4),
                  Text(label)
                ]),
                crossFadeState:
                    !selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 100))),
        selected: selected,
        onSelected: onSelected);
  }
}
