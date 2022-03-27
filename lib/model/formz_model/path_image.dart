import 'package:formz/formz.dart';

enum PathImageValidationError { invalid, empty }

class PathImage extends FormzInput<String, PathImageValidationError> {
  const PathImage.pure() : super.pure('');
  const PathImage.dirty([String value = '']) : super.dirty(value);

  @override
  PathImageValidationError? validator(String value) {
    if (value.isNotEmpty != true) PathImageValidationError.empty;
    if (value.length < 20) return PathImageValidationError.invalid;
    return null;
  }
}
