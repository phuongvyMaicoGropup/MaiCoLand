import 'package:formz/formz.dart';
import 'package:maico_land/helpers/validator_tranformer.dart';

enum CodeValidationError { invalid, empty }

class Code extends FormzInput<String, CodeValidationError> {
  const Code.pure() : super.pure('');
  const Code.dirty([String value = '']) : super.dirty(value);

  @override
  CodeValidationError? validator(String value) {
    if (value.isNotEmpty != true) CodeValidationError.empty;
    if (!ValidatorsTransformer.isValidCode(value)) {
      return CodeValidationError.invalid;
    }
    return null;
  }
}
