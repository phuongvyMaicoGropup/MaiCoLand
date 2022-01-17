
import 'package:formz/formz.dart';
import 'package:land_app/helpers/validator_tranformer.dart';

enum ContentValidationError{invalid,empty}
class Content extends FormzInput<String, ContentValidationError>{
  const Content.pure() : super.pure('');
  const Content.dirty([String value = '']) : super.dirty(value);

  @override
  ContentValidationError? validator(String value) {
    if (value.isNotEmpty != true ) ContentValidationError.empty;
    return null ; 
  }


}