import 'package:equatable/equatable.dart';
import 'package:maico_land/model/formz_model/models.dart';
import 'package:maico_land/model/formz_model/phone.dart';

import '../../model/formz_model/code.dart';

enum CheckVariable { notCheck, success, failure }
enum Loading { notloading, loading }

class ForgotPasswordState extends Equatable {
  final Phone phone;
  final Code code;
  final Password password;
  final CheckVariable isCheckedCode;
  final CheckVariable isCheckedPhone;
  final Loading isLoading;
  final Password repassword;
  final String userName;
  const ForgotPasswordState(
      {this.phone = const Phone.pure(),
      this.userName = "",
      this.code = const Code.pure(),
      this.password = const Password.pure(),
      this.repassword = const Password.pure(),
      this.isCheckedCode = CheckVariable.notCheck,
      this.isCheckedPhone = CheckVariable.notCheck,
      this.isLoading = Loading.notloading});
  @override
  List<Object> get props => [
        phone,
        userName,
        code,
        password,
        repassword,
        isCheckedCode,
        isCheckedPhone,
        isLoading
      ];
  ForgotPasswordState copyWith({
    Phone? phone,
    String? userName,
    Code? code,
    Password? password,
    Password? repassword,
    CheckVariable? isCheckedCode,
    CheckVariable? isCheckedPhone,
    Loading? isLoading,
  }) {
    print(isCheckedPhone);
    return ForgotPasswordState(
        phone: phone ?? this.phone,
        userName: userName ?? this.userName,
        code: code ?? this.code,
        password: password ?? this.password,
        repassword: repassword ?? this.repassword,
        isCheckedCode: isCheckedCode ?? this.isCheckedCode,
        isCheckedPhone: isCheckedPhone ?? this.isCheckedPhone,
        isLoading: isLoading ?? this.isLoading);
  }
}
