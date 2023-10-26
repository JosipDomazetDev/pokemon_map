import 'package:flutter/material.dart';

import '../../utils/type_colors.dart';

class TypeChip extends StatelessWidget {
  final String type;
  final bool isLarge;

  const TypeChip({
    super.key,
    required this.type,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 11;

    if (isLarge) {
      fontSize = 14;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: typeColors[type] ?? Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          type,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}
