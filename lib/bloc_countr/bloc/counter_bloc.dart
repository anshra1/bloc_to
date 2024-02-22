import 'package:bloc/bloc.dart';
import 'package:bloc_to/bloc_countr/bloc/counter_state.dart';
import 'package:meta/meta.dart';
part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<CounterIncrement>(
      (event, emit) {
        emit(IncrementState(count: state.count + 1));
      },
    );
    on<CounterDecrement>(
      (event, emit) {
        emit(DecrementState(count: state.count - 1));
      },
    );
  }
}
