import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

class AuthState extends Equatable {
  final User? user;
  final FormzStatus loggedStatus;

  AuthState({
    this.user,
    this.loggedStatus = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [
        user,
        loggedStatus,
      ];

  AuthState copyWith({
    User? user,
    FormzStatus? loggedStatus,
  }) =>
      AuthState(
        user: user ?? this.user,
        loggedStatus: loggedStatus ?? this.loggedStatus,
      );
}
