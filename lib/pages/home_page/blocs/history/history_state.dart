part of 'history_bloc.dart';

class HistoryState {
  List<Transaction> historyTransaction;

  HistoryState({
    required this.historyTransaction,
  });

  HistoryState copyWith({
    List<Transaction>? historyTransaction,
  }) {
    return HistoryState(
      historyTransaction: historyTransaction ?? this.historyTransaction,
    );
  }
}
