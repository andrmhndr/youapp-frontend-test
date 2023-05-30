part of 'auth_bloc.dart';

enum AuthStatus { authorized, unauthorized }

class AuthState extends Equatable {
  final User user;
  final AuthStatus authStatus;

  const AuthState._({
    required this.user,
    required this.authStatus,
  });

  AuthState.unauthenticated()
      : this._(user: User.empty(), authStatus: AuthStatus.unauthorized);

  const AuthState.authenticated(User user)
      : this._(user: user, authStatus: AuthStatus.authorized);

  @override
  List<Object> get props => [
        user,
        authStatus,
      ];

  AuthState copyWith({
    User? user,
    AuthStatus? authStatus,
  }) {
    return AuthState._(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
