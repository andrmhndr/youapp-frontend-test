import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    key: Key('logout_button'),
                    onPressed: () {
                      context.read<ProfileBloc>().add(LogoutProfile());
                      context.read<AuthBloc>().add(LogoutAuth());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Colors.white,
                        ),
                        Text(
                          style: Get.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                          'Back',
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      '@${state.profile.username}',
                      style: Get.textTheme.titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container())
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('something wrong'),
          );
        }
      },
    );
  }
}
