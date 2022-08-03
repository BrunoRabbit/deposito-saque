// ignore_for_file: unnecessary_null_comparison

import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionController extends ChangeNotifier {
  List<Transaction> listTransaction = [];
  double currentMoney = 0;
  double value = 209000;
  Transaction? transaction;

  final DateFormat formatter = DateFormat('EEEE, HH:mm aaa, d/MMM yy');

  convertAndTransfer(String moneyTransfer, BuildContext context) async {
    final DateTime dateTime = DateTime.now();
    transaction = Transaction();
    currentMoney = UtilBrasilFields.converterMoedaParaDouble(
      moneyTransfer,
    );

    if (currentMoney > 0 && currentMoney <= value) {
      value += currentMoney;
      listTransaction.add(
        transaction = transaction!.copyWith(
          name: 'Transferred',
          transferred: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.arrowRightArrowLeft,
        ),
      );
      notifyListeners();
      sucessSnackBar('Successfully transferred', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Check the value and try again', context);
    }
  }

  verifyValueResgate(String resgateController, BuildContext context) async {
    if (resgateController.isNotEmpty) {
      await convertAndResgate(resgateController, context);
    } else {
      failedSnackBar('Redeemed value cannot be empty!', context);
    }
    notifyListeners();
  }

  convertAndResgate(resgateController, context) {
    final DateTime dateTime = DateTime.now();
    transaction = Transaction();

    currentMoney = UtilBrasilFields.converterMoedaParaDouble(
      resgateController,
    );

    if (currentMoney > 0 && currentMoney <= value) {
      value -= currentMoney;
      listTransaction.add(
        transaction = transaction!.copyWith(
          name: 'Withdraw',
          withdraw: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.dollarSign,
        ),
      );
      notifyListeners();
      sucessSnackBar('Successfully rescued', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Check the value and try again', context);
    }
  }

  verifyValueDeposit(String moneyController, BuildContext context) async {
    if (moneyController.isNotEmpty) {
      await convertAndDeposit(moneyController, context);
    } else {
      failedSnackBar('Amount deposited cannot be empty!', context);
    }

    notifyListeners();
  }

  convertAndDeposit(String moneyController, BuildContext context) {
    final DateTime dateTime = DateTime.now();
    transaction = Transaction();

    currentMoney = UtilBrasilFields.converterMoedaParaDouble(
      moneyController,
    );

    if (currentMoney != 0 && currentMoney != null && currentMoney >= 3) {
      value += currentMoney;
      listTransaction.add(
        transaction = transaction!.copyWith(
          name: 'Deposit',
          deposit: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.moneyBill1Wave,
        ),
      );
      notifyListeners();
      sucessSnackBar('Successfully deposited', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Check the value and try again', context);
    }
  }
}
