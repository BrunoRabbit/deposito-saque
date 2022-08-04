import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/models/transaction_decoration.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        color: getDecoration().cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: getDecoration().bannerBackgroundColor,
                child: Icon(
                  getDecoration().icon,
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
                          label: transaction.type.name,
                        ),
                        AppCustomText(
                          label: getTransactionValue(),
                          color: getDecoration().currentBalanceColor,
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

  TransactionDecoration getDecoration() {
    if (transaction.type == TransactionType.Withdraw) {
      return TransactionDecoration(
        cardBackgroundColor: Colors.red[100]!,
        currentBalanceColor: Colors.red[900]!,
        bannerBackgroundColor: Colors.redAccent,
        icon: FontAwesomeIcons.dollarSign,
      );
    } else if (transaction.type == TransactionType.Transferred) {
      return TransactionDecoration(
        cardBackgroundColor: Colors.blue[100]!,
        currentBalanceColor: Colors.blue[900]!,
        bannerBackgroundColor: Colors.blue,
        icon: FontAwesomeIcons.moneyBill1Wave,
      );
    } else {
      return TransactionDecoration(
        cardBackgroundColor: Colors.green[100]!,
        currentBalanceColor: Colors.green[900]!,
        bannerBackgroundColor: const Color.fromARGB(255, 4, 179, 77),
        icon: FontAwesomeIcons.arrowRightArrowLeft,
      );
    }
  }

  String getTransactionValue() {
    if (transaction.type == TransactionType.Deposit) {
      return UtilBrasilFields.obterReal(transaction.total!);
    } else if (transaction.type == TransactionType.Transferred) {
      return UtilBrasilFields.obterReal(transaction.total!);
    } else {
      return UtilBrasilFields.obterReal(transaction.total!);
    }
  }
}
