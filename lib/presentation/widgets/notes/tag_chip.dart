import 'package:flutter/material.dart';
import 'package:worklife_memo_flutter/data/models/tag_model.dart';

class TagChip extends StatelessWidget {
  final Tag tag;

  const TagChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name),
    );
  }
}
