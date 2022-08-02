// ignore_for_file: unnecessary_null_comparison

import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/models/transaction.dart';
import 'package:deposito_saque/widgets/app_snack_bar.dart';
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
          name: 'Transferido',
          transferido: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.arrowRightArrowLeft,
          bgColor: Colors.blue[100],
          moneyColor: Colors.blue[900],
        ),
      );
      notifyListeners();
      sucessSnackBar('Transferido com sucesso', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Verifique o valor e tente novamente', context);
    }
  }

  verifyValueResgate(String resgateController, BuildContext context) async {
    if (resgateController.isNotEmpty) {
      await convertAndResgate(resgateController, context);
    } else {
      failedSnackBar('Valor resgatado não pode ser vazio!', context);
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
          name: 'Resgate',
          resgate: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.dollarSign,
          bgColor: Colors.red[100],
          moneyColor: Colors.red[900],
        ),
      );
      notifyListeners();
      sucessSnackBar('Resgatado com sucesso', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Verifique o valor e tente novamente', context);
    }
  }

  verifyValueDeposit(String moneyController, BuildContext context) async {
    if (moneyController.isNotEmpty) {
      await convertAndDeposit(moneyController, context);
    } else {
      failedSnackBar('Valor depositado não pode ser vazio!', context);
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
          name: 'Depósito',
          deposito: currentMoney,
          dateTime: formatter.format(dateTime),
          icon: FontAwesomeIcons.moneyBill1Wave,
          bgColor: Colors.green[100],
          moneyColor: Colors.green[900],
        ),
      );
      notifyListeners();
      sucessSnackBar('Depositado com sucesso', context);
      Navigator.of(context).pop();
    } else {
      failedSnackBar('Verifique o valor e tente novamente', context);
    }
  }
}
