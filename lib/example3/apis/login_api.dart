
import 'package:bloc_learning/example3/login_handle_model.dart';

abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

class LoginApis implements LoginApiProtocol {
  const LoginApis._sharedInstance();
  static const _shared = LoginApis._sharedInstance();
  factory LoginApis.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.foobar() : null,
      );
}

