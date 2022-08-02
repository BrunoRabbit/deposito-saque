import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> sucessSnackBar(
  String title,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xff3F3FFE),
      content: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          InkWell(
            child: const Text('Dispensar'),
            onTap: () {
              scaffoldKey.currentState!.hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> failedSnackBar(
  String title,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          InkWell(
            child: const Text('Dispensar'),
            onTap: () {
              scaffoldKey.currentState!.hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ),
  );
}
