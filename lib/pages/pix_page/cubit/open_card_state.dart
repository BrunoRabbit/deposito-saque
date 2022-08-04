part of 'open_card_cubit.dart';

class OpenCardState {
  final bool isOpen;

  OpenCardState({
    required this.isOpen,
  });

  OpenCardState copyWith({bool? isOpen}) {
    return OpenCardState(
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
