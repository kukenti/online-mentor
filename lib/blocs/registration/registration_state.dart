import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/core/input_validators.dart';

// Registration State
class RegistrationState extends Equatable {
  final UserType userType;
  final String name;
  final String surname;
  final int age;
  final String address;
  final Email email;
  final Phone phoneNumber;
  final Required<String> password;
  final String language;
  final EducationType educationType;
  final String classification;
  final String workingPeriod;
  final FormzStatus registrationStatus;
  final String error;

  RegistrationState({
    this.userType = UserType.student,
    this.name = '',
    this.surname = '',
    this.age = 0,
    this.address = '',
    this.email = const Email.pure(),
    this.phoneNumber = const Phone.pure(),
    this.password = const Required.pure(),
    this.language = '',
    this.educationType = EducationType.primary,
    this.classification = '',
    this.workingPeriod = '',
    this.registrationStatus = FormzStatus.pure,
    this.error = '',
  });

  @override
  List<Object?> get props => [
        userType,
        name,
        surname,
        age,
        address,
        email,
        phoneNumber,
        password,
        language,
        educationType,
        classification,
        workingPeriod,
        registrationStatus,
        error,
      ];

  RegistrationState copyWith({
    UserType? userType,
    String? name,
    String? surname,
    int? age,
    String? address,
    Email? email,
    Phone? phoneNumber,
    Required<String>? password,
    String? language,
    EducationType? educationType,
    String? classification,
    String? workingPeriod,
    FormzStatus? registrationStatus,
    String? error,
  }) {
    return RegistrationState(
      userType: userType ?? this.userType,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      address: address ?? this.address,
      email: email ?? this.email,
      password: password ?? this.password,
      language: language ?? this.language,
      educationType: educationType ?? this.educationType,
      classification: classification ?? this.classification,
      workingPeriod: workingPeriod ?? this.workingPeriod,
      registrationStatus: registrationStatus ?? this.registrationStatus,
      error: error ?? this.error,
    );
  }
}
