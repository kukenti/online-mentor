import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
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
          .toList();
      emit(state.copyWith(
        teachers: teachers,
        status: FormzStatus.submissionSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

    emit(state.copyWith(
      status: FormzStatus.pure,
    ));
  }
}
