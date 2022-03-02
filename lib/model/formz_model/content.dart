
import 'package:formz/formz.dart';

enum ContentValidationError{invalid,empty}
class Content extends FormzInput<String, ContentValidationError>{
  const Content.pure() : super.pure('');
  const Content.dirty([String value = '']) : super.dirty(value);

  @override
  ContentValidationError? validator(String value) {
    if (value.isNotEmpty != true ) ContentValidationError.empty;
    if (value.length < 10) return ContentValidationError.invalid;
    return null ; 
  }


}