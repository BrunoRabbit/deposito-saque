// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState(historyTransaction: [])) {
    on<AddTransactionToHistory>(_onAddTransactionToHistory);
  }

  final DateFormat formatter = DateFormat('EEEE, HH:mm aaa, d/MMM yy');

  _onAddTransactionToHistory(
      AddTransactionToHistory event, Emitter<HistoryState> emit) {
    final currentHistory = state.historyTransaction;

    currentHistory.add(event.transaction);

    emit(HistoryState(historyTransaction: currentHistory));
  }
}
