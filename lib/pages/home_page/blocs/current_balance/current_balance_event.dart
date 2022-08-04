part of 'current_balance_bloc.dart';

@immutable
abstract class CurrentBalanceEvent {}

class ChangeBalanceValue extends CurrentBalanceEvent {
  final double currentBalance;

  ChangeBalanceValue({
    required this.currentBalance,
  });
}
