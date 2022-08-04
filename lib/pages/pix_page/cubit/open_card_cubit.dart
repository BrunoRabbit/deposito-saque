import 'package:bloc/bloc.dart';

part 'open_card_state.dart';

class OpenCardCubit extends Cubit<OpenCardState> {
  OpenCardCubit() : super(OpenCardState(isOpen: false));

  void isFormOpen(bool isOpen) => emit(state.copyWith(isOpen: isOpen));
}
