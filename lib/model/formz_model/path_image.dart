import 'package:formz/formz.dart';

enum PathImageValidationError { invalid, empty }

class PathImage extends FormzInput<List<String>?, PathImageValidationError> {
  const PathImage.pure() : super.pure(null);
  const PathImage.dirty([List<String>? value]) : super.dirty(value);

  @override
  PathImageValidationError? validator(List<String>? value) {
    if (value?.isNotEmpty != true) PathImageValidationError.empty;
    return null;
  }
}
