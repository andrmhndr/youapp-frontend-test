part of 'profile_controller_cubit.dart';

class ProfileControllerState extends Equatable {
  final Profile profile;
  final File? image;
  final bool expanded;

  const ProfileControllerState({
    this.image,
    required this.profile,
    required this.expanded,
  });

  factory ProfileControllerState.initial() {
    return ProfileControllerState(
      profile: Profile.empty(),
      expanded: false,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        expanded,
        image,
      ];

  ProfileControllerState copyWith({
    Profile? profile,
    bool? expanded,
    File? image,
  }) {
    return ProfileControllerState(
      profile: profile ?? this.profile,
      expanded: expanded ?? this.expanded,
      image: image ?? this.image,
    );
  }
}
