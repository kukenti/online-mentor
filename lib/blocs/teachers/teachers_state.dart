import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/models/user/user.dart';

class TeachersState extends Equatable {
  final List<Teacher> teachers;
  final List<Teacher> filteredTeachers;
  final EducationType? educationType;
  final FormzStatus status;

  TeachersState({
    this.teachers = const [],
    this.filteredTeachers = const [],
    this.status = FormzStatus.pure,
    this.educationType,
  });

  @override
  List<Object?> get props => [
        teachers,
        filteredTeachers,
        educationType,
        status,
      ];

  TeachersState copyWith({
    List<Teacher>? teachers,
    List<Teacher>? filteredTeachers,
    EducationType? educationType,
    FormzStatus? status,
  }) =>
      TeachersState(
        teachers: teachers ?? this.teachers,
        filteredTeachers: filteredTeachers ?? this.filteredTeachers,
        educationType: educationType ?? this.educationType,
        status: status ?? this.status,
      );
  TeachersState reset({
    EducationType? educationType,
  }) =>
      TeachersState(
        teachers: teachers,
        filteredTeachers: filteredTeachers,
        educationType: educationType,
        status: status,
      );
}
