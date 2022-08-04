import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_balance_event.dart';
part 'current_balance_state.dart';

class CurrentBalanceBloc
    extends Bloc<CurrentBalanceEvent, CurrentBalanceState> {
  CurrentBalanceBloc() : super(const CurrentBalanceState(currentBalance: 300)) {
    on<ChangeBalanceValue>(_onChangeBalanceValue);
  }
  _onChangeBalanceValue(
      ChangeBalanceValue event, Emitter<CurrentBalanceState> emit) {
    final currentState = state.currentBalance;

    emit(
      CurrentBalanceState(currentBalance: currentState + event.currentBalance),
    );
  }
}
