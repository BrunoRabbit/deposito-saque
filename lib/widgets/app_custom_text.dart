import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCustomText extends StatelessWidget {
  final double? size;
  final String label;
  final FontWeight? fontWeight;
  final Color? color;

  const AppCustomText({
    Key? key,
    this.size,
    required this.label,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.roboto(
        fontSize: size ?? 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
      ),
    );
  }
}
