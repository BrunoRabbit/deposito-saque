part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {
  const HistoryEvent();
}

class AddTransactionToHistory extends HistoryEvent {
  final Transaction transaction;

  const AddTransactionToHistory({
    required this.transaction,
  });
}
