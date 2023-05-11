import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:online_mentor/blocs/teachers/teachers_cubit.dart';
import 'package:online_mentor/blocs/teachers/teachers_state.dart';
import 'package:online_mentor/service_locator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getIt<TeachersCubit>().fetchTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeachersCubit, TeachersState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.teachers.isNotEmpty) {
          return ListView.builder(
            itemCount: state.teachers.length,
            itemBuilder: (context, index) {
              final teacher = state.teachers[index];
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  '${teacher.name} ${teacher.surname}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          Text(
                            teacher.phoneNumber ?? '',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                          ),
                          Text(
                            teacher.email ?? '',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Customize the ListTile as per your needs
              );
            },
          );
        } else {
          return Center(
              // child: Text(state.error),
              );
        }
      },
    );
  }
}
