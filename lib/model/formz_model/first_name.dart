import 'package:formz/formz.dart';

enum FirstNameValidationError{invalid, empty}

class FirstName extends FormzInput<String, FirstNameValidationError>{
  const FirstName.pure(): super.pure('');
  const FirstName.dirty([String value ='']): super.dirty(value);
  @override
  FirstNameValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return FirstNameValidationError.empty;
    if (value!.length < 4) return FirstNameValidationError.invalid; 
    if (value.contains(' ')) return FirstNameValidationError.invalid;
    return null; 
  }
  
}

