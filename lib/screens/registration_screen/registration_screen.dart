import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:online_mentor/blocs/registration/registration_cubit.dart';
import 'package:online_mentor/blocs/registration/registration_state.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/core/input_validators.dart';
import 'package:online_mentor/screens/login_screen/login_screen.dart';
import 'package:online_mentor/service_locator.dart';
import 'package:online_mentor/utils/primary_snackbar.dart';
import 'package:online_mentor/widgets/forms/primary_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('registration'),
              RegistrationForm(),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
                child: Text(
                  'already_have_account',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  late final TextEditingController _emailTextController =
      _createTextEditingController('', () {
    getIt<RegistrationCubit>().setEmail(_emailTextController.text);
  });
  late final TextEditingController _passwordTextController =
      _createTextEditingController('', () {
    getIt<RegistrationCubit>().setName(_passwordTextController.text);
  });
  late final TextEditingController _phoneNumberTextController =
      _createTextEditingController('', () {
    getIt<RegistrationCubit>().setPhone(_phoneNumberTextController.text);
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listenWhen: (p, c) => p.registrationStatus != c.registrationStatus,
      buildWhen: (p, c) =>
          p.userType != c.userType ||
          p.registrationStatus != c.registrationStatus,
      listener: (context, state) {
        if (state.registrationStatus.isSubmissionInProgress) {
          // Show loading indicator
        } else if (state.registrationStatus.isSubmissionFailure) {
          // Show error snackbar
          PrimarySnackbar.showSnackbar(context: context, message: state.error);
        } else if (state.registrationStatus.isSubmissionSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        final phoneFormatter = MaskTextInputFormatter(
          mask: '+###########',
          filter: {"#": RegExp(r'[0-9]')},
          initialText: state.phoneNumber.value,
        );

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<UserType>(
                value: state.userType,
                onChanged: (value) =>
                    context.read<RegistrationCubit>().setUserType(value!),
                items: [
                  for (var userType in UserType.values)
                    DropdownMenuItem(
                      value: userType,
                      child: Text(userType.label ?? ''),
                    ),
                ],
                decoration: InputDecoration(
                  labelText: 'User Type',
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  onChanged: (value) =>
                      context.read<RegistrationCubit>().setName(value),
                  labelText: 'Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  onChanged: (value) =>
                      context.read<RegistrationCubit>().setSurname(value),
                  labelText: 'Surname',
                ),
              ),
              if (state.userType == UserType.student)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PrimaryTextField(
                    onChanged: (value) => context
                        .read<RegistrationCubit>()
                        .setAge(int.tryParse(value) ?? 0),
                    labelText: 'Age',
                    keyboardType: TextInputType.number,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  onChanged: (value) =>
                      context.read<RegistrationCubit>().setAddress(value),
                  labelText: 'Address',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  controller: _phoneNumberTextController,
                  inputFormatters: [
                    phoneFormatter,
                  ],
                  labelText: 'phone_number',
                  keyboardType: TextInputType.phone,
                  hasError: state.phoneNumber.invalid,
                  errorText:
                      state.phoneNumber.invalid ? 'Неверный телефон' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  controller: _emailTextController,
                  labelText: 'Email',
                  hasError: state.email.invalid,
                  errorText: state.email.error?.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BlocBuilder<RegistrationCubit, RegistrationState>(
                  builder: (context, state) {
                    return PrimaryTextField(
                      onChanged: (value) =>
                          context.read<RegistrationCubit>().setPassword(value),
                      labelText: 'Password',
                      hasError: state.password.invalid,
                      errorText: state.password.error.value,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BlocBuilder<RegistrationCubit, RegistrationState>(
                  builder: (context, state) {
                    return PrimaryTextField(
                      onChanged: (value) =>
                          context.read<RegistrationCubit>().setLanguage(value),
                      labelText: 'Language',
                      hasError: state.password.invalid,
                      errorText: state.password.error.value,
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              if (state.userType == UserType.teacher)
                DropdownButtonFormField<EducationType>(
                  value: state.educationType,
                  onChanged: (value) =>
                      context.read<RegistrationCubit>().setEducation(value!),
                  items: [
                    for (var educationType in EducationType.values)
                      DropdownMenuItem(
                        value: educationType,
                        child: Text(educationType.label ?? ''),
                      ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Education',
                  ),
                ),
              SizedBox(height: 16.0),
              if (state.userType == 'teacher')
                DropdownButtonFormField<String>(
                  value: state.classification,
                  onChanged: (value) => context
                      .read<RegistrationCubit>()
                      .setClassification(value!),
                  items: [
                    DropdownMenuItem(
                      value: 'primary',
                      child: Text('Primary Education'),
                    ),
                    DropdownMenuItem(
                      value: 'secondary',
                      child: Text('Secondary Education'),
                    ),
                    DropdownMenuItem(
                      value: 'high_school',
                      child: Text('High School Education'),
                    ),
                    DropdownMenuItem(
                      value: 'college',
                      child: Text('College Education'),
                    ),
                    DropdownMenuItem(
                      value: 'university',
                      child: Text('University Education'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Classification',
                  ),
                ),
              SizedBox(height: 16.0),
              if (state.userType == 'teacher')
                TextFormField(
                  onChanged: (value) =>
                      context.read<RegistrationCubit>().setWorkingPeriod(value),
                  decoration: InputDecoration(
                    labelText: 'Working Period',
                  ),
                ),
              SizedBox(height: 16.0),
              BlocBuilder<RegistrationCubit, RegistrationState>(
                buildWhen: (p, c) =>
                    p.registrationStatus != c.registrationStatus,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: context.read<RegistrationCubit>().registerUser,
                    child: state.registrationStatus.isSubmissionInProgress
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Register'),
                  );
                },
              ),
            ],
          ),
        );
      },
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
