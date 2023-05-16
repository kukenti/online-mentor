import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/blocs/profiile_edit/profile_edit_state.dart';
import 'package:online_mentor/blocs/profile/profile_cubit.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/core/input_validators.dart';
import 'package:online_mentor/models/user/user.dart';
import 'package:online_mentor/repositories/user_repository.dart';

@lazySingleton
class ProfileEditCubit extends Cubit<ProfileEditState> {
  final fba.FirebaseAuth _firebaseAuth = fba.FirebaseAuth.instance;
  final UserRepository _userRepository;
  final ProfileCubit profileCubit;

  ProfileEditCubit(
    this._userRepository,
    this.profileCubit,
  ) : super(ProfileEditState()) {
    handleProfileChanged(profileCubit.state.user);

    profileCubit.stream.listen((event) {
      handleProfileChanged(event.user);
    });
  }

  void handleProfileChanged(User? user) {
    if (user == null) {
      return;
    }
    emit(state.copyWith(
      userType: user.userType,
      name: user.name,
      surname: user.surname,
      age: user.age,
      address: user.address,
      email: Email.dirty(user.email),
      phoneNumber: Phone.dirty(user.phoneNumber ?? ''),
      language: user.language,
      educationType: user.educationType,
    ));
  }

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
      registrationStatus: Formz.validate([state.email, state.phoneNumber]),
    ));

    try {
      // Additional registration logic based on user type
      if (state.userType == UserType.student) {
        await _userRepository.saveUser(User(
          userId: profileCubit.state.userId,
          name: state.name,
          surname: state.surname,
          age: state.age,
          address: state.address,
          email: state.email.value,
          language: 'ru',
          userType: UserType.student,
        ));
      } else if (state.userType == UserType.teacher) {
        await _userRepository.saveUser(Teacher(
          userId: profileCubit.state.userId,
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
    if (error is fba.FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'weak-password':
          return 'The password is too weak.';
        default:
          return 'ProfileEdit failed. Please try again.';
      }
    } else {
      return 'ProfileEdit failed. Please try again.';
    }
  }

  setPhone(String value) {
    final Phone _phone = Phone.dirty(value);
    emit(state.copyWith(
      phoneNumber: _phone,
    ));
  }
}
