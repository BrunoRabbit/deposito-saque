// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Transaction {
  String? name;
  double? resgate;
  double? deposito;
  double? transferido;
  String? dateTime;
  IconData? icon;

  Transaction({
    this.name,
    this.resgate,
    this.deposito,
    this.transferido,
    this.dateTime,
    this.icon,
  });

  Transaction copyWith({
    String? name,
    double? resgate,
    double? deposito,
    double? transferido,
    String? dateTime,
    IconData? icon,
    Color? bgColor,
    Color? moneyColor,
  }) {
    return Transaction(
      name: name ?? this.name,
      resgate: resgate ?? this.resgate,
      deposito: deposito ?? this.deposito,
      transferido: transferido ?? this.transferido,
      dateTime: dateTime ?? this.dateTime,
      icon: icon ?? this.icon,
    );
  }
}
