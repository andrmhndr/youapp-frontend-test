import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:youapp_test/helper/api_helper.dart';
import 'package:youapp_test/models/user_model.dart';
import 'package:youapp_test/repositories/api_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiRepository _apiRepository;
  StreamSubscription? userAuth;

  AuthBloc({
    required ApiRepository apiRepository,
  })  : _apiRepository = apiRepository,
        super(AuthState.unauthenticated()) {
    on<LoginAuth>(_onLoginAuth);
    on<CheckAuth>(_onCheckAuth);
    on<LogoutAuth>(_onLogoutAuth);
    on<RegisterAuth>(_onRegisterAuth);
  }

  Future<void> _onRegisterAuth(
      RegisterAuth event, Emitter<AuthState> emit) async {
    User user = await _apiRepository.register(
        event.username, event.email, event.password);
    if (user != User.empty()) {
      emit(AuthState.authenticated(user));
    }
  }

  void _onLogoutAuth(LogoutAuth event, Emitter<AuthState> emit) {
    userAuth?.cancel;
    emit(AuthState.unauthenticated());
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    userAuth?.cancel();
    if (state.user.token != '') {
      userAuth = _apiRepository.auth(state.user.token).listen((event) {
        if (event == ApiHelper.unauthorized) {
          emit(AuthState.unauthenticated());
        }
      });
    }
  }

  Future<void> _onLoginAuth(LoginAuth event, Emitter<AuthState> emit) async {
    User user = await _apiRepository.login(event.email, event.password);
    if (user.token != '') {
      emit(AuthState.authenticated(user));
    }
  }
}
