// import 'package:formz/formz.dart';

// enum HashTagsValidationError{invalid, empty}

// class HashTags extends FormzInput<List<String>, HashTagsValidationError>{
//   const HashTags.pure(): super.pure(List<String>());
//   const HashTags.dirty([List<String> value =[]]): super.dirty(value);
//   @override
//   HashTagsValidationError? validator(List<String>? value) {
//     if (value?.isNotEmpty != true )  return HashTagsValidationError.empty;
//     if (value!.length < 10) return HashTagsValidationError.invalid;
//     return null; 
//   }
  
// }