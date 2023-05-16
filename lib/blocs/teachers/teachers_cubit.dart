import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/models/user/user.dart';

import 'teachers_state.dart';

@lazySingleton
class TeachersCubit extends Cubit<TeachersState> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  TeachersCubit() : super(TeachersState()) {
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    try {
      final querySnapshot =
          await usersCollection.where('userType', isEqualTo: 'teacher').get();
      final teachers = querySnapshot.docs
          .map((doc) => Teacher.fromJson(doc.data() as Map<String, dynamic>))
          .where((element) => state.educationType != null
              ? element.educationType == state.educationType
              : true)
          .toList();
      emit(state.copyWith(
        teachers: teachers,
        filteredTeachers: teachers,
        status: FormzStatus.submissionSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

    emit(state.copyWith(
      status: FormzStatus.pure,
    ));
  }

  Future<void> searchQueryChanged(String text) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    try {
      emit(state.copyWith(
        filteredTeachers: state.teachers
            .where((element) => _searchFilter(element, text))
            .where((element) => state.educationType != null
                ? element.educationType == state.educationType
                : true)
            .toList(),
        status: FormzStatus.submissionSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

    emit(state.copyWith(
      status: FormzStatus.pure,
    ));
  }

  bool _searchFilter(Teacher element, String query) {
    if (query.isEmpty) {
      return true;
    }
    if ([
      element.name.toLowerCase(),
      element.surname.toLowerCase(),
      element.age,
      element.address.toLowerCase(),
      element.email.toLowerCase(),
      element.userType.label?.toLowerCase(),
      element.educationType?.label?.toLowerCase(),
      element.specialty?.name?.toLowerCase(),
      element.phoneNumber?.toLowerCase(),
    ].any((element) => element.toString().contains(query.toLowerCase()))) {
      return true;
    }

    return false;
  }

  handleEducationTypeChanged(EducationType e) {
    if (state.educationType == e) {
      emit(state.reset(educationType: null));
    } else {
      emit(state.copyWith(
        educationType: e,
      ));
    }
    fetchTeachers();
  }
}
