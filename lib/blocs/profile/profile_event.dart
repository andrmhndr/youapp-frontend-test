part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LogoutProfile extends ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class RefreshProfile extends ProfileEvent {
  final Profile profile;

  const RefreshProfile({required this.profile});

  @override
  List<Object> get props => [
        profile,
      ];
}

class UpdateProfile extends ProfileEvent {
  final Profile profile;

  const UpdateProfile({
    required this.profile,
  });

  @override
  List<Object> get props => [
        profile,
      ];
}
