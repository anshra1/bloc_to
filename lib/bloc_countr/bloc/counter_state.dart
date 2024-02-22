class CounterState {
  final int count;

  CounterState({required this.count});
}

class IncrementState extends CounterState {
  IncrementState({required super.count});
}

class DecrementState extends CounterState {
  DecrementState({required super.count});
}
