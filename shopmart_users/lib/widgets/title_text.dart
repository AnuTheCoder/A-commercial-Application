import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({Key? key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(label,
      maxLines: 4,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis
      ),
    );
  }
}
