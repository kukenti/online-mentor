import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/blocs/login/login_cubit.dart';

import 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final LoginCubit loginCubit;

  AuthCubit(this.loginCubit) : super(AuthState()) {
    checkAuthStatus();
    loginCubit.stream.listen((event) {
      if (event.loginStatus.isSubmissionSuccess) {
        checkAuthStatus();
      }
    });
  }

  void checkAuthStatus() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        emit(state.copyWith(
          loggedStatus: FormzStatus.submissionSuccess,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          loggedStatus: FormzStatus.submissionFailure,
          user: null,
        ));
      }
    });
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(
        loggedStatus: FormzStatus.submissionInProgress,
      ));
      await _firebaseAuth.signOut();
      emit(state.copyWith(
        user: null,
        loggedStatus: FormzStatus.submissionInProgress,
      ));
    } catch (e) {
      // Handle sign-out errors
      emit(state.copyWith(
        loggedStatus: FormzStatus.submissionFailure,
      ));
    }
    emit(state.copyWith(
      loggedStatus: FormzStatus.pure,
    ));
  }
}
