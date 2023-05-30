import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/converter_helper.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, stateProfile) {
            if (stateProfile is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (stateProfile is ProfileLoaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    image: stateProfile.profile.image == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                                base64.decode(stateProfile.profile.image!))),
                    color: ColorHelper.containerBackground,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                width: double.infinity,
                height: 190,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      bottom: 17,
                      left: 13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@${stateProfile.profile.username}, ${stateProfile.profile.birthday == null ? null : ConverterHelper.calculateAge(stateProfile.profile.birthday!)}',
                            style: Get.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          stateProfile.profile.gender == null
                              ? Text(
                                  '-',
                                  style: Get.textTheme.bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              : Text(
                                  '${stateProfile.profile.gender!.name.capitalizeFirst}',
                                  style: Get.textTheme.bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                          stateProfile.profile.birthday == null
                              ? Row()
                              : Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: ColorHelper.interestBox,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: Text(
                                        stateProfile.profile.horoscope,
                                        style: Get.textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: ColorHelper.interestBox,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: Text(
                                        stateProfile.profile.horoscope,
                                        style: Get.textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('something wrong'),
              );
            }
          },
        );
      },
    );
  }
}
