part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppLogin implements AppEvent {
  final String email;
  final String password;
  const AppLogin({
    required this.email,
    required this.password,
  });
}

class LoadNotesEvent extends AppEvent {
  const LoadNotesEvent();
}
