import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/helper/color_helper.dart';
import 'package:youapp_test/helper/gradient_helper.dart';
import 'package:youapp_test/helper/images_helper.dart';
import 'package:youapp_test/models/user_model.dart';
import 'package:youapp_test/routes/routes_name.dart';
import 'package:youapp_test/views/widgets/image_background.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final formKey = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authorized) {
          Get.back();
        }
      },
      child: ImageBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
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
                        'Register',
                        style: Get.textTheme.headlineMedium!
                            .copyWith(color: Colors.white),
                      )),
                  SizedBox(height: 25),
                  _InputEmail(controllerEmail: controllerEmail),
                  SizedBox(
                    height: 15,
                  ),
                  _InputUsername(controllerUsername: controllerUsername),
                  SizedBox(
                    height: 15,
                  ),
                  _InputPassword(controllerPassword: controllerPassword),
                  SizedBox(
                    height: 15,
                  ),
                  _InputConfirmPassword(
                      controllerConfirmPassword: controllerConfirmPassword,
                      controllerPassword: controllerPassword),
                  SizedBox(
                    height: 20,
                  ),
                  _RegisterButton(
                    formKey: formKey,
                    controllerConfirmPassword: controllerConfirmPassword,
                    controllerEmail: controllerEmail,
                    controllerPassword: controllerPassword,
                    controllerUsername: controllerUsername,
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
                        'Have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: GradientText(
                          'Login here',
                          style: Get.textTheme.bodyMedium!
                              .copyWith(decoration: TextDecoration.underline),
                          gradient: LinearGradient(
                              colors: ColorHelper.goldenGradient),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    super.key,
    required this.formKey,
    required this.controllerEmail,
    required this.controllerUsername,
    required this.controllerPassword,
    required this.controllerConfirmPassword,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController controllerEmail;
  final TextEditingController controllerUsername;
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        key: Key('register_button'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(
                  RegisterAuth(
                    username: controllerUsername.value.text,
                    email: controllerEmail.value.text,
                    password: controllerPassword.value.text,
                  ),
                );
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
            'Register',
            style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _InputPassword extends StatefulWidget {
  _InputPassword({
    super.key,
    required this.controllerPassword,
  });

  final TextEditingController controllerPassword;

  @override
  State<_InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<_InputPassword> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: TextFormField(
        key: Key("password_input"),
        controller: widget.controllerPassword,
        validator: (value) {
          if (value == '') {
            return 'password cannot be empty';
          }
          return null;
        },
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        obscureText: !isVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: GradientIcon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              gradient: LinearGradient(colors: ColorHelper.goldenGradient),
            ),
          ),
          hintText: 'Create Password',
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

class _InputConfirmPassword extends StatefulWidget {
  const _InputConfirmPassword({
    super.key,
    required this.controllerConfirmPassword,
    required this.controllerPassword,
  });

  final TextEditingController controllerConfirmPassword;
  final TextEditingController controllerPassword;

  @override
  State<_InputConfirmPassword> createState() => _InputConfirmPasswordState();
}

class _InputConfirmPasswordState extends State<_InputConfirmPassword> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: TextFormField(
        key: Key("confirm_password_input"),
        controller: widget.controllerConfirmPassword,
        validator: (value) {
          if (value != widget.controllerPassword.value.text) {
            return 'different password';
          } else if (value == '') {
            return 'password cannot be empty';
          }
          return null;
        },
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        obscureText: !isVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: GradientIcon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              gradient: LinearGradient(colors: ColorHelper.goldenGradient),
            ),
          ),
          hintText: 'Confirm Password',
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

class _InputEmail extends StatelessWidget {
  const _InputEmail({
    required this.controllerEmail,
    super.key,
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
            return 'Insert correct email';
          }
          return null;
        },
        controller: controllerEmail,
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Enter Email',
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
  const _InputUsername({super.key, required this.controllerUsername});

  final TextEditingController controllerUsername;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: TextFormField(
        key: Key("username_input"),
        validator: (value) {
          if (value == '') {
            return 'username cannot be empty';
          }
          return null;
        },
        controller: controllerUsername,
        style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Create Username',
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
