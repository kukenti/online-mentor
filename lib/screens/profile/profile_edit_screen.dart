import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:online_mentor/blocs/profiile_edit/profile_edit_cubit.dart';
import 'package:online_mentor/blocs/profiile_edit/profile_edit_state.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/core/input_validators.dart';
import 'package:online_mentor/screens/login_screen/login_screen.dart';
import 'package:online_mentor/service_locator.dart';
import 'package:online_mentor/utils/primary_snackbar.dart';
import 'package:online_mentor/widgets/forms/primary_text_field.dart';

class ProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Profile edit'),
              ProfileEditForm(),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'Назад',
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

class ProfileEditForm extends StatelessWidget {
  final ProfileEditCubit profileEditCubit = getIt<ProfileEditCubit>();
  late final TextEditingController _nameTextController =
      _createTextEditingController(profileEditCubit.state.name, () {
    getIt<ProfileEditCubit>().setName(_nameTextController.text);
  });
  late final TextEditingController _surnameTextController =
      _createTextEditingController(profileEditCubit.state.surname, () {
    getIt<ProfileEditCubit>().setSurname(_surnameTextController.text);
  });
  late final TextEditingController _addressTextController =
      _createTextEditingController(profileEditCubit.state.address, () {
    getIt<ProfileEditCubit>().setAddress(_addressTextController.text);
  });
  late final TextEditingController _emailTextController =
      _createTextEditingController(profileEditCubit.state.email.value, () {
    getIt<ProfileEditCubit>().setEmail(_emailTextController.text);
  });
  late final TextEditingController _phoneNumberTextController =
      _createTextEditingController(profileEditCubit.state.phoneNumber.value,
          () {
    getIt<ProfileEditCubit>().setPhone(_phoneNumberTextController.text);
  });
  late final TextEditingController _languageTextController =
      _createTextEditingController(profileEditCubit.state.language, () {
    getIt<ProfileEditCubit>().setPhone(_languageTextController.text);
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileEditCubit, ProfileEditState>(
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
          Navigator.of(context).popUntil((route) => route.isFirst);
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
              ListTile(
                title: Text('Тип пользователя'),
                subtitle: Text(state.userType.label ?? ""),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  controller: _nameTextController,
                  labelText: 'Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  controller: _surnameTextController,
                  labelText: 'Surname',
                ),
              ),
              if (state.userType == UserType.student)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PrimaryTextField(
                    onChanged: (value) => context
                        .read<ProfileEditCubit>()
                        .setAge(int.tryParse(value) ?? 0),
                    labelText: 'Age',
                    keyboardType: TextInputType.number,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PrimaryTextField(
                  controller: _addressTextController,
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
                child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                  builder: (context, state) {
                    return PrimaryTextField(
                      controller: _languageTextController,
                      labelText: 'Language',
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              if (state.userType == UserType.teacher)
                DropdownButtonFormField<EducationType>(
                  value: state.educationType,
                  onChanged: (value) =>
                      context.read<ProfileEditCubit>().setEducation(value!),
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
              BlocBuilder<ProfileEditCubit, ProfileEditState>(
                buildWhen: (p, c) =>
                    p.registrationStatus != c.registrationStatus,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: context.read<ProfileEditCubit>().registerUser,
                    child: state.registrationStatus.isSubmissionInProgress
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Сохранить'),
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
