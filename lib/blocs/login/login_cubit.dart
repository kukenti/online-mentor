import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/core/input_validators.dart';

import 'login_state.dart';

@lazySingleton
class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginCubit() : super(LoginState());

  void emailChanged(String email) {
    final Email _email = Email.dirty(email);

    emit(state.copyWith(
      email: _email,
    ));
  }

  void passwordChanged(String password) {
    final Required<String> _password = Required.dirty(password);

    emit(state.copyWith(
      password: _password,
    ));
  }

  Future<void> signInWithEmailAndPassword() async {
    emit(state.copyWith(
        loginStatus: Formz.validate([
      state.email,
      state.password,
    ])));

    if (state.loginStatus.isInvalid) {
      return;
    }
    try {
      emit(state.copyWith(
        loginStatus: FormzStatus.submissionInProgress,
      ));
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value!,
      );
      emit(state.copyWith(
        loginStatus: FormzStatus.submissionSuccess,
      ));
    } on FirebaseAuthException catch (e) {
      // Parse and handle Firebase login error cases
      String errorMessage = _parseFirebaseError(e);
      emit(state.copyWith(
        loginStatus: FormzStatus.submissionFailure,
        error: errorMessage,
      ));
    } catch (e) {
      emit(state.copyWith(
          loginStatus: FormzStatus.submissionFailure, error: e.toString()));
    }
    emit(state.copyWith(
      loginStatus: FormzStatus.pure,
    ));
  }

  String _parseFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An error occurred during login.';
    }
  }
}
