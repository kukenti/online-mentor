import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/blocs/login/login_cubit.dart';
import 'package:online_mentor/blocs/login/login_state.dart';
import 'package:online_mentor/core/colors.dart';
import 'package:online_mentor/core/images.dart';
import 'package:online_mentor/core/input_validators.dart';
import 'package:online_mentor/screens/main_screen/main_screen.dart';
import 'package:online_mentor/screens/registration_screen/registration_screen.dart';
import 'package:online_mentor/service_locator.dart';
import 'package:online_mentor/utils/primary_snackbar.dart';
import 'package:online_mentor/widgets/forms/primary_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailTextController =
      _createTextEditingController('', () {
    getIt<LoginCubit>().emailChanged(_emailTextController.text);
  });
  late final TextEditingController _passwordTextController =
      _createTextEditingController('', () {
    getIt<LoginCubit>().passwordChanged(_passwordTextController.text);
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.loginStatus != c.loginStatus,
      listener: (context, state) {
        if (state.loginStatus.isSubmissionFailure) {
          PrimarySnackbar.showSnackbar(context: context, message: state.error);
        } else if (state.loginStatus.isSubmissionSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(imgLogo),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PrimaryTextField(
                          controller: _emailTextController,
                          labelText: 'email',
                          isInvalid: state.email.invalid,
                          errorText: state.email.error?.value,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PrimaryTextField(
                          controller: _passwordTextController,
                          labelText: 'password',
                          obscureText: true,
                          isInvalid: state.password.invalid,
                          errorText: state.password.error.value,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (p, c) => p.loginStatus != c.loginStatus,
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: primaryColor,
                          ),
                          onPressed:
                              getIt<LoginCubit>().signInWithEmailAndPassword,
                          child: state.loginStatus.isSubmissionInProgress
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Login'),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Метод для создания контроллера для текствого поля
  TextEditingController _createTextEditingController(
    String? initialValue,
    VoidCallback action,
  ) {
    TextEditingController textEditingController =
        TextEditingController(text: initialValue ?? '');
    textEditingController.addListener(
      action,
    );

    return textEditingController;
  }
}
