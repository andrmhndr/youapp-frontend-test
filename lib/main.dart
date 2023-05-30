import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/blocs/auth/auth_bloc.dart';
import 'package:youapp_test/blocs/profile/profile_bloc.dart';
import 'package:youapp_test/cubits/profile%20controller/profile_controller_cubit.dart';
import 'package:youapp_test/helper/app_theme.dart';
import 'package:youapp_test/repositories/api_repository.dart';
import 'package:youapp_test/routes/app_page_route.dart';
import 'package:youapp_test/views/home/initial_page.dart';
import 'package:youapp_test/views/login/login_page.dart';
import 'package:youapp_test/views/register/register_page.dart';

void main() {
  runApp(const MainProvider());
}

class MainProvider extends StatelessWidget {
  const MainProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileControllerCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              apiRepository: context.read<ApiRepository>(),
            )..add(CheckAuth()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              apiRepository: context.read<ApiRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
        ],
        child: MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        getPages: AppPageRoute.pages,
        theme: AppTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.authStatus == AuthStatus.authorized) {
              return InitialPage();
            } else {
              return LoginPage();
            }
          },
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           Get.to(() => LoginPage());
        //         },
        //         child: Text('Login'),
        //       ),
        //       TextButton(
        //         onPressed: () {
        //           Get.to(() => RegisterPage());
        //         },
        //         child: Text('Register'),
        //       ),
        //       TextButton(
        //         onPressed: () {
        //           Get.to(() => InitialPage());
        //         },
        //         child: Text('Initial Page'),
        //       ),
        //     ],
        //   ),
        // ),

        );
  }
}
