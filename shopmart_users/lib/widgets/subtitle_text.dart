import 'dart:ui';

import 'package:flutter/material.dart';

class SubtitleTextWidget extends StatelessWidget {
    const SubtitleTextWidget({super.key, required this.label,this.fontSize = 25,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.bold,this.color = Colors.yellow,
    this.textDecoration = TextDecoration.underline});

  final String label;
  final double fontSize;
  final fontStyle;
  final fontWeight;
  final color;
  final textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(label,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: TextDecoration.none,
          color: color,
          fontStyle: fontStyle,

      ),
    );
  }
}
