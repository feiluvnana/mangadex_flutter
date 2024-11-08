import 'package:flutter/material.dart';

class TagChipSkeleton extends StatelessWidget {
  final String tagName;
  const TagChipSkeleton({super.key, required this.tagName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Text(tagName,
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.colorScheme.onPrimaryContainer)));
  }
}
