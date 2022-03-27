import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class FirstNameInput extends StatelessWidget {
  const FirstNameInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_firstNameInput_textField'),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterFirstNameChanged(value)),
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
            labelText: "Tên",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText: state.firstName.invalid
                ? 'Kí tự không bao gồm dấu cách.'
                : null,
          ),
        );
      },
    );
  }
}
