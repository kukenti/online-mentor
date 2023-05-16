import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/blocs/teachers/teachers_cubit.dart';
import 'package:online_mentor/blocs/teachers/teachers_state.dart';
import 'package:online_mentor/core/colors.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/service_locator.dart';
import 'package:online_mentor/widgets/forms/primary_text_field.dart';

import 'widgets/teacher_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchTextController =
      _createTextEditingController('', () {
    getIt<TeachersCubit>().searchQueryChanged(_searchTextController.text);
  });

  @override
  void initState() {
    getIt<TeachersCubit>().fetchTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                left: 12,
                right: 12,
                top: 12,
              ),
              child: PrimaryTextField(
                controller: _searchTextController,
                hintText: 'search',
              ),
            ),
            SizedBox(
              height: 60,
              child: BlocBuilder<TeachersCubit, TeachersState>(
                builder: (context, state) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: [
                      SizedBox(width: 20),
                      ...EducationType.values.map((e) => InkWell(
                            onTap: () => getIt<TeachersCubit>().handleEducationTypeChanged(e),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: state.educationType == e
                                    ? primaryColor
                                    : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: Offset(0, 1),
                                    blurRadius: 20,
                                    spreadRadius: 0.1,
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(
                                right: 10,
                              ),
                              child: Center(child: Text(e.label ?? "")),
                            ),
                          ))
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TeachersCubit, TeachersState>(
                builder: (context, state) {
                  if (state.status == FormzStatus.submissionInProgress) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.filteredTeachers.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.filteredTeachers.length,
                      itemBuilder: (context, index) {
                        final teacher = state.filteredTeachers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: TeacherCard(teacher: teacher),
                        );
                      },
                    );
                  } else {
                    return Center(
                        // child: Text(state.error),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Метод для создания контроллера для текствого поля
  TextEditingController _createTextEditingController(
    String? initialValue,
    VoidCallback action,
  ) {
    TextEditingController textEditingController =
        TextEditingController(text: initialValue ?? '');
    textEditingController.addListener(
      action,
    );

    return textEditingController;
  }
}
