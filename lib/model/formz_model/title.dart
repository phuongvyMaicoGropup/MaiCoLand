import 'package:formz/formz.dart';
import 'package:land_app/helpers/validator_tranformer.dart';

enum TitleValidationError{invalid, empty}

class Title extends FormzInput<String, TitleValidationError>{
  const Title.pure(): super.pure('');
  const Title.dirty([String value ='']): super.dirty(value);
  @override
  TitleValidationError? validator(String? value) {
    if (value?.isNotEmpty != true )  return TitleValidationError.empty;
    if (value!.length < 10) return TitleValidationError.invalid;
    return null; 
  }
  
}