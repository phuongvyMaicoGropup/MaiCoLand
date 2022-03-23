import 'package:formz/formz.dart';

enum LastNameValidationError{invalid, empty}

class LastName extends FormzInput<String, LastNameValidationError>{
  const LastName.pure(): super.pure('');
  const LastName.dirty([String value ='']): super.dirty(value);
  @override
  LastNameValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return LastNameValidationError.empty;
    if (value!.length < 2) return LastNameValidationError.invalid; 
    if (value.contains(' ')) return LastNameValidationError.invalid;
    return null; 
  }
  
}

