
import 'package:formz/formz.dart';
import 'package:land_app/helpers/validator_tranformer.dart';

enum PasswordValidationError{invalid,empty}
class Password extends FormzInput<String, PasswordValidationError>{
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isNotEmpty != true ) PasswordValidationError.empty;
    if (!ValidatorsTransformer.isValidPassword(value)) return PasswordValidationError.invalid; 
    return null ; 
  }


}