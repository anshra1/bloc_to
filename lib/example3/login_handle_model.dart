import 'package:equatable/equatable.dart';

class LoginHandle extends Equatable {
  final String token;

  const LoginHandle({
    required this.token,
  });

  const LoginHandle.foobar() : token = 'foobar';

  @override
  String toString() => 'LoginHandle(token: $token)';

  @override
  List<Object?> get props => [token];
}


