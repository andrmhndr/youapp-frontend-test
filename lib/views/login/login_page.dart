import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/gradient_helper.dart';
import 'package:youapp_test/helper/images_helper.dart';
import 'package:youapp_test/routes/routes_name.dart';
import 'package:youapp_test/views/widgets/image_background.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ImageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
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
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 41),
                          child: Text(
                            'Login',
                            style: Get.textTheme.headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 25),
                        _InputUsername(controllerEmail: controllerEmail),
                        SizedBox(
                          height: 15,
                        ),
                        _InputPassword(
                          controllerPassword: controllerPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _LoginButton(
                          email: controllerEmail,
                          password: controllerPassword,
                          formKey: formKey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              style: Get.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                              'No account?',
                            ),
                            TextButton(
                              key: Key('to_register_button'),
                              onPressed: () {
                                // print(state);
                                Get.toNamed(RouteName.goRegisterPage);
                              },
                              child: GradientText(
                                'Register here',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                    decoration: TextDecoration.underline),
                                gradient: LinearGradient(
                                    colors: ColorHelper.goldenGradient),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        key: Key('login_button'),
        onPressed: () {
          print('login');
          if (formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(LoginAuth(
                email: email.value.text, password: password.value.text));
            context.read<ProfileBloc>().add(LoadProfile());
          }
        },
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xff4599DB).withOpacity(0.5),
                  // spreadRadius: 8,
                  blurRadius: 16,
                  offset: Offset(2, 8)),
              BoxShadow(
                  color: Color(0xff62CDCB).withOpacity(0.5),
                  blurRadius: 16,
                  // spreadRadius: 8,
                  offset: Offset(0, 8)),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: ColorHelper.blueGradient,
            ),
          ),
          child: Text(
            'Login',
            style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _InputPassword extends StatefulWidget {
  const _InputPassword({
    required this.controllerPassword,
    super.key,
  });

  final TextEditingController controllerPassword;

  @override
  State<_InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<_InputPassword> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: TextFormField(
        key: Key("password_input"),
        validator: (value) {
          if (value == '') {
            return 'input password correctly';
          }
          return null;
        },
        controller: widget.controllerPassword,
        obscureText: !visible,
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            },
            icon: GradientIcon(
              visible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              gradient: LinearGradient(colors: ColorHelper.goldenGradient),
            ),
          ),
          hintText: 'Enter Password',
          hintStyle: Get.textTheme.bodyMedium!
              .copyWith(color: Colors.white.withOpacity(0.4)),
          fillColor: Colors.white.withOpacity(0.06),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(9)),
          filled: true,
        ),
      ),
    );
  }
}

class _InputUsername extends StatelessWidget {
  const _InputUsername({
    super.key,
    required this.controllerEmail,
  });

  final TextEditingController controllerEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: TextFormField(
        key: Key("email_input"),
        validator: (value) {
          if (!GetUtils.isEmail(value!)) {
            return 'input email correctly';
          }
          return null;
        },
        controller: controllerEmail,
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Enter Username/Email',
          hintStyle: Get.textTheme.bodyMedium!
              .copyWith(color: Colors.white.withOpacity(0.4)),
          fillColor: Colors.white.withOpacity(0.06),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(9)),
          filled: true,
        ),
      ),
    );
  }
}
