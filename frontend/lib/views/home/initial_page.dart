import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/gradient_helper.dart';
import 'package:youapp_test/views/home/components/about_component.dart';
import 'package:youapp_test/views/home/components/appbar_component.dart';
import 'package:youapp_test/views/home/components/interests_component.dart';
import 'package:youapp_test/views/home/components/profile_component.dart';
import 'package:youapp_test/views/home/edit_interest.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            AppBarComponent(),
            const SizedBox(
              height: 10,
            ),
            const ProfileInfo(),
            const SizedBox(
              height: 24,
            ),
            const AboutContainer(),
            const SizedBox(
              height: 18,
            ),
            InterestContainer()
          ],
        ),
      ),
    );
  }
}
