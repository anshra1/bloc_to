import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listener_test_event.dart';
part 'listener_test_state.dart';

class ListenerTestBloc extends Bloc<ListenerTestEvent, int> {
  ListenerTestBloc() : super(0) {
    on<ListenerEvent>((event, emit) {
      emit(10);
      emit(20);
      emit(30);
      emit(40);
    });

    on<Increment>((event, emit) {
      emit(state + 10);
    });

    on<Decrement>((event, emit) {
      emit(state - 10);
    });
  }
}
