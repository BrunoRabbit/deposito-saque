import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

import 'package:deposito_saque/models/transaction.dart';

class CardHistorico extends StatelessWidget {
  final Transaction transaction;

  const CardHistorico({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: transaction.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: getBannerBackground(),
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
                          label: transaction.resgate != null
                              ? UtilBrasilFields.obterReal(transaction.resgate!)
                              : UtilBrasilFields.obterReal(
                                  transaction.deposito ??
                                      transaction.transferido!),
                          color: transaction.moneyColor,
                        ),
                      ],
                    ),
                    AppCustomText(
                      label: transaction.dateTime!,
                      size: 16,
                      fontWeight: FontWeight.w400,
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

  Color getBannerBackground() {
    if (transaction.resgate != null) {
      return Colors.redAccent;
    } else if (transaction.transferido != null) {
      return Colors.blue;
    } else {
      return const Color.fromARGB(255, 4, 179, 77);
    }
  }
}
