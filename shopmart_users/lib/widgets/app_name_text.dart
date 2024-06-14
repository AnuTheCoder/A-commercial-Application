import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopmart_users/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize=20});
final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: Duration(seconds: 12),
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        child: TitlesTextWidget(label: "ShopSmart",
        fontSize: fontSize,
        ));
  }
}
