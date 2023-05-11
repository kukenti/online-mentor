import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/models/user/user.dart';

class TeachersState extends Equatable {
  final List<Teacher> teachers;
  final FormzStatus status;

  TeachersState({
    this.teachers = const [],
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [
        teachers,
        status,
      ];

  TeachersState copyWith({
    List<Teacher>? teachers,
    FormzStatus? status,
  }) =>
      TeachersState(
        teachers: teachers ?? this.teachers,
        status: status ?? this.status,
      );
}
