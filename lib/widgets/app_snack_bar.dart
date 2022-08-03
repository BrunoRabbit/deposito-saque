import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

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
          AppCustomText(
            label: title,
            size: 16,
          ),
          const Spacer(),
          InkWell(
            child: const Text('Dismiss'),
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
          AppCustomText(
            label: title,
            size: 16,
          ),
          const Spacer(),
          InkWell(
            child: const Text('Dismiss'),
            onTap: () {
              scaffoldKey.currentState!.hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ),
  );
}
