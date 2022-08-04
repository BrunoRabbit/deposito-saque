// ignore_for_file: constant_identifier_names

part 'transaction_type.dart';

class Transaction {
  final TransactionType type;
  final double? total;
  final String? dateTime;

  Transaction({
    required this.type,
    this.total,
    this.dateTime,
  });

  Transaction copyWith({
    TransactionType? type,
    double? total,
    String? dateTime,
  }) {
    return Transaction(
      type: type ?? this.type,
      total: total ?? this.total,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
