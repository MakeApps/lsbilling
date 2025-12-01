import 'package:formz/formz.dart';

// class Email extends FormzInput<String, EmailValidationError> {
//   /// {@macro email}
//   const Email.pure() : super.pure('');

//   /// {@macro email}
//   const Email.dirty([super.value = '']) : super.dirty();

//   static final RegExp _emailRegExp = RegExp(
//     r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
//   );

//   @override
//   EmailValidationError? validator(String? value) {
//     return _emailRegExp.hasMatch(value ?? '')
//         ? null
//         : EmailValidationError.invalid;
//   }
// }
enum EmailValidationError { empty }

class Email extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const Email.pure() : super.pure('');

  /// {@macro email}
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    return (value == null || value.isEmpty) ? EmailValidationError.empty : null;
  }
}

enum PasswordValidationError {
  /// Generic invalid error.
  invalid,
  empty,
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  // static final _passwordRegExp = RegExp(r'[A-Za-z\d]{6,}$');
  static final _passwordRegExp = RegExp(r'^.{6,}$');

  //RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
