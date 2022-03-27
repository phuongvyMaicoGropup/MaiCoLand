import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_EmailInput_textField'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Email",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText:
                state.email.invalid ? 'Vui lòng nhập đúng định dạng!' : null,
          ),
        );
      },
    );
  }
}
