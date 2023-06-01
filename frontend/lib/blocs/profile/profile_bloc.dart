import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/models/profile_model.dart';
import 'package:youapp_test/repositories/api_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final ApiRepository _apiRepository;
  StreamSubscription? _profileSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required ApiRepository apiRepository,
  })  : _apiRepository = apiRepository,
        _authBloc = authBloc,
        super(ProfileLoading()) {
    on<UpdateProfile>(_onUpdateProfile);
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
    on<LogoutProfile>(_onLogoutProfile);
  }

  void _onLogoutProfile(LogoutProfile event, Emitter<ProfileState> emit) {
    _profileSubscription?.cancel();
    emit(ProfileLoading());
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    _apiRepository.updateProfile(
        _authBloc.state.user.token, _authBloc.state.user.email, event.profile);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    _profileSubscription?.cancel();
    _profileSubscription = _apiRepository
        .loadProfile(_authBloc.state.user.token, _authBloc.state.user.email)
        .listen(
      (profile) {
        try {
          add(
            RefreshProfile(
              profile: Profile(
                username: profile.username,
                image: profile.image,
                gender: profile.gender,
                birthday: profile.birthday,
                height: profile.height,
                weight: profile.weight,
                interests: profile.interests,
              ),
            ),
          );
        } catch (err) {
          print(err);
        }
      },
    );
  }

  void _onRefreshProfile(RefreshProfile event, Emitter<ProfileState> emit) {
    emit(ProfileLoaded(profile: event.profile));
  }
}
