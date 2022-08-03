import 'package:flutter/material.dart';

class AppCustomText extends StatelessWidget {
  final double? size;
  final String label;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;

  const AppCustomText({
    Key? key,
    this.size,
    required this.label,
    this.fontWeight,
    this.color,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily ?? 'Roboto-Regular',
        fontSize: size ?? 18,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
