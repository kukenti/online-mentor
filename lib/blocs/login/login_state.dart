import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/core/input_validators.dart';

class LoginState extends Equatable {
  final Email email;
  final Required<String> password;
  final FormzStatus loginStatus;
  final String error;

  LoginState({
    this.email = const Email.pure(),
    this.password = const Required.pure(),
    this.loginStatus = FormzStatus.pure,
    this.error = '',
  });

  @override
  List<Object?> get props => [
        email,
        password,
        loginStatus,
        error,
      ];

  LoginState copyWith({
    Email? email,
    Required<String>? password,
    FormzStatus? loginStatus,
    String? error,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        error: error ?? this.error,
      );
}
