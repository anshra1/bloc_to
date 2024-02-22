part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

class CounterIncrement implements CounterEvent {}

class CounterDecrement implements CounterEvent {}
