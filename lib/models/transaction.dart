// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Transaction {
  String? name;
  double? withdraw;
  double? deposit;
  double? transferred;
  String? dateTime;
  IconData? icon;

  Transaction({
    this.name,
    this.withdraw,
    this.deposit,
    this.transferred,
    this.dateTime,
    this.icon,
  });

  Transaction copyWith({
    String? name,
    double? withdraw,
    double? deposit,
    double? transferred,
    String? dateTime,
    IconData? icon,
    Color? bgColor,
    Color? moneyColor,
  }) {
    return Transaction(
      name: name ?? this.name,
      withdraw: withdraw ?? this.withdraw,
      deposit: deposit ?? this.deposit,
      transferred: transferred ?? this.transferred,
      dateTime: dateTime ?? this.dateTime,
      icon: icon ?? this.icon,
    );
  }
}
