import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/blocs/auth/auth_state.dart';
import 'package:online_mentor/core/colors.dart';
import 'package:online_mentor/screens/login_screen/login_screen.dart';
import 'package:online_mentor/screens/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.loggedStatus.isSubmissionSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3DD598),
            ),
          ),
        );
      },
    );
  }
}
