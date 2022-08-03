import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

import 'package:deposit_withdraw/models/transaction.dart';

class HistoryCard extends StatelessWidget {
  final Transaction transaction;

  const HistoryCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: _getCardBackground(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _getBannerBackground(),
                child: Icon(
                  transaction.icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppCustomText(
                          label: transaction.name!,
                        ),
                        AppCustomText(
                          label: transaction.withdraw != null
                              ? UtilBrasilFields.obterReal(
                                  transaction.withdraw!)
                              : UtilBrasilFields.obterReal(
                                  transaction.deposit ??
                                      transaction.transferred!),
                          color: _getMoneyColor(),
                        ),
                      ],
                    ),
                    AppCustomText(
                      label: transaction.dateTime!,
                      size: 16,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardBackground() {
    if (transaction.withdraw != null) {
      return Colors.red[100]!;
    } else if (transaction.transferred != null) {
      return Colors.blue[100]!;
    } else {
      return Colors.green[100]!;
    }
  }

  Color _getMoneyColor() {
    if (transaction.withdraw != null) {
      return Colors.red[900]!;
    } else if (transaction.transferred != null) {
      return Colors.blue[900]!;
    } else {
      return Colors.green[900]!;
    }
  }

  Color _getBannerBackground() {
    if (transaction.withdraw != null) {
      return Colors.redAccent;
    } else if (transaction.transferred != null) {
      return Colors.blue;
    } else {
      return const Color.fromARGB(255, 4, 179, 77);
    }
  }
}
