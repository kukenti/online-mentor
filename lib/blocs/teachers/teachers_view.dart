import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'teachers_cubit.dart';
import 'teachers_state.dart';

class TeachersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TeachersCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<TeachersCubit>(context);

    return Container();
  }
}


