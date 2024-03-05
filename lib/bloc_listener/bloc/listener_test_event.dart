part of 'listener_test_bloc.dart';

sealed class ListenerTestEvent extends Equatable {
  const ListenerTestEvent();

  @override
  List<Object> get props => [];
}

class ListenerEvent implements ListenerTestEvent {
  @override
  List<Object> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}

class Increment implements ListenerTestEvent {
  @override
  
  List<Object> get props => throw UnimplementedError();

  @override

  bool? get stringify => throw UnimplementedError();
}

class Decrement implements ListenerTestEvent {
  @override
 
  List<Object> get props => throw UnimplementedError();

  @override
 
  bool? get stringify => throw UnimplementedError();
}
