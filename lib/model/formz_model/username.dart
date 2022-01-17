import 'package:formz/formz.dart';

enum UsernameValidationError{invalid, empty}

class Username extends FormzInput<String, UsernameValidationError>{
  const Username.pure(): super.pure('');
  const Username.dirty([String value ='']): super.dirty(value);
  @override
  UsernameValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return UsernameValidationError.empty;
    if (value!.length < 4) return UsernameValidationError.invalid; 
    return null; 
  }
  
}