import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/blocs/login/login_cubit.dart';
import 'package:online_mentor/blocs/profiile_edit/profile_edit_cubit.dart';
import 'package:online_mentor/blocs/profile/profile_cubit.dart';
import 'package:online_mentor/blocs/registration/registration_cubit.dart';
import 'package:online_mentor/blocs/teachers/teachers_cubit.dart';
import 'package:online_mentor/screens/splash_screen/splash_screen.dart';
import 'package:online_mentor/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<RegistrationCubit>()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
        BlocProvider(create: (context) => getIt<TeachersCubit>()),
        BlocProvider(create: (context) => getIt<ProfileEditCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
