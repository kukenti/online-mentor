import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/core/input_validators.dart';
import 'package:online_mentor/models/user/user.dart';
import 'package:online_mentor/repositories/user_repository.dart';

import 'registration_state.dart';

@lazySingleton
class RegistrationCubit extends Cubit<RegistrationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository _userRepository;

  RegistrationCubit(this._userRepository) : super(RegistrationState());

  void setUserType(UserType userType) {
    emit(state.copyWith(userType: userType));
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setSurname(String surname) {
    emit(state.copyWith(surname: surname));
  }

  void setAge(int age) {
    emit(state.copyWith(age: age));
  }

  void setAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void setEmail(String email) {
    final Email _email = Email.dirty(email);
    emit(state.copyWith(email: _email));
  }

  void setPassword(String password) {
    final Required<String> _password = Required.dirty(password);
    emit(state.copyWith(password: _password));
  }

  void setLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void setEducation(EducationType education) {
    emit(state.copyWith(educationType: education));
  }

  void setClassification(String classification) {
    emit(state.copyWith(classification: classification));
  }

  void setWorkingPeriod(String workingPeriod) {
    emit(state.copyWith(workingPeriod: workingPeriod));
  }

  Future<void> registerUser() async {
    emit(state.copyWith(
      registrationStatus: Formz.validate([
        state.email,
        state.password,
      ]),
    ));

    try {
      // emit(state.copyWith(isLoading: true));
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value!,
      );

      if (userCredential.user == null) {
        return;
      }

      // Additional registration logic based on user type
      if (state.userType == UserType.student) {
        await _userRepository.saveUser(Student(
          userId: userCredential.user!.uid,
          name: state.name,
          surname: state.surname,
          age: state.age,
          address: state.address,
          email: state.email.value,
          language: 'ru',
        ));
      } else if (state.userType == UserType.teacher) {
        await _userRepository.saveUser(Teacher(
          userId: userCredential.user!.uid,
          name: state.name,
          surname: state.surname,
          age: state.age,
          address: state.address,
          phoneNumber: state.phoneNumber.value,
          email: state.email.value,
        ));
      }

      emit(state.copyWith(
        registrationStatus: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      String errorMessage = _parseFirebaseError(e);
      emit(state.copyWith(
        registrationStatus: FormzStatus.submissionFailure,
        error: errorMessage,
      ));
      debugPrint(e.toString());
    }
    emit(state.copyWith(
      registrationStatus: FormzStatus.pure,
    ));
  }

  String _parseFirebaseError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'weak-password':
          return 'The password is too weak.';
        default:
          return 'Registration failed. Please try again.';
      }
    } else {
      return 'Registration failed. Please try again.';
    }
  }

  setPhone(String value) {
    final Phone _phone = Phone.dirty(value);
    emit(state.copyWith(
      phoneNumber: _phone,
    ));
  }
}
