import 'package:formz/formz.dart';

enum RequiredError { invalid }

extension RequiredErrorExt on RequiredError? {
  static const keyMap = {
    RequiredError.invalid: 'required_field',
  };

  // название на русском
  static const valueMap = {
    RequiredError.invalid: 'Обязательное поле',
  };

  String? get value => valueMap[this];

  String? get key => keyMap[this];
}

class Required<T> extends FormzInput<T?, RequiredError> {
  const Required.pure() : super.pure(null);

  const Required.dirty(T? value) : super.dirty(value);

  @override
  RequiredError? validator(T? value) {
    return value != null ? null : RequiredError.invalid;
  }
}

enum EmailValidationError {
  empty,
  invalid,
}

extension EmailValidationErrorExt on EmailValidationError {
  static const keyMap = {
    EmailValidationError.invalid: "invalid",
    EmailValidationError.empty: "empty",
  };

  static const valueMap = {
    EmailValidationError.invalid: "Неверная почта",
    EmailValidationError.empty: "Обязательное поле",
  };

  String? get value => valueMap[this];

  String? get key => keyMap[this];
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    if ((value ?? '').isEmpty) {
      return EmailValidationError.empty;
    }
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}


enum PhoneValidationError { invalid, lengthLimit }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r'^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,3})|(\(?\d{2,3}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$',
  );

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}