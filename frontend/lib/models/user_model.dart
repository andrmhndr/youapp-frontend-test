import 'package:equatable/equatable.dart';
import 'package:youapp_test/helper/api_helper.dart';

class User extends Equatable {
  final String email;
  final String password;
  final String token;

  const User({
    required this.email,
    required this.password,
    required this.token,
  });

  factory User.empty() {
    return const User(
      email: '',
      password: '',
      token: '',
    );
  }

  factory User.login(json, email, password) {
    return User(
      email: email,
      password: password,
      token: json[ApiHelper.token],
    );
  }

  factory User.register(json, username, email, password) {
    return User(email: email, password: password, token: json[ApiHelper.token]);
  }

  @override
  List<Object?> get props => [
        email,
        password,
        token,
      ];
}
