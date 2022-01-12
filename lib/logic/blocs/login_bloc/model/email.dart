import 'package:formz/formz.dart';
import 'package:land_app/helpers/validator_tranformer.dart';

enum EmailValidationError{invalid, empty}

class Email extends FormzInput<String, EmailValidationError>{
  const Email.pure(): super.pure('');
  const Email.dirty([String value ='']): super.dirty(value);
  @override
  EmailValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return EmailValidationError.empty;
    if (!ValidatorsTransformer.isValidEmail(value!)) return EmailValidationError.invalid;
    return null; 
  }
  
}