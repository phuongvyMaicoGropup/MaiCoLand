import 'package:formz/formz.dart';
import 'package:land_app/helpers/validator_tranformer.dart';

enum PhoneValidationError{invalid, empty}

class Phone extends FormzInput<String, PhoneValidationError>{
  const Phone.pure(): super.pure('');
  const Phone.dirty([String value ='']): super.dirty(value);
  @override
  PhoneValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return PhoneValidationError.empty;
    if (!ValidatorsTransformer.isValidPhone(value!)) return PhoneValidationError.invalid;
    return null; 
  }
  
}