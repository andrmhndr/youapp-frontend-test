part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuth extends AuthEvent {}

class LogoutAuth extends AuthEvent {}

class LoginAuth extends AuthEvent {
  final String email;
  final String password;

  const LoginAuth({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterAuth extends AuthEvent {
  final String username;
  final String password;
  final String email;

  const RegisterAuth({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [
        username,
        password,
        email,
      ];
}
