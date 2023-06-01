import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youapp_test/models/profile_model.dart';

part 'profile_controller_state.dart';

class ProfileControllerCubit extends Cubit<ProfileControllerState> {
  ProfileControllerCubit() : super(ProfileControllerState.initial());

  void reverseExpand() {
    emit(state.copyWith(expanded: !state.expanded));
  }

  void getProfile(Profile profile) {
    emit(state.copyWith(profile: profile));
  }

  void setUsername(String username) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(username: username),
      ),
    );
  }

  void setGender(Gender gender) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(gender: gender),
      ),
    );
  }

  void setBirthday(DateTime? birthday) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(birthday: birthday),
      ),
    );
  }

  void setWeight(int weight) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(weight: weight),
      ),
    );
  }

  void setHeight(int height) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(height: height),
      ),
    );
  }

  void setInterests(List<String> interests) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(interests: interests),
      ),
    );
  }

  void setImage(String image) {
    emit(state.copyWith(profile: state.profile.copyWith(image: image)));
  }
}
