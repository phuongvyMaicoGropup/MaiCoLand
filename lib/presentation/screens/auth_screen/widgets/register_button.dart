import 'package:formz/formz.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Đăng ký tài khoản thành công"),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        } else if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Tên tài khoản hoặc email đã được đăng ký. Vui lòng kiểm tra thông tin!"),
              backgroundColor: Colors.red,
            ),
          );
        }
        // do stuff here based on BlocA's state
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == FormzStatus.submissionInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return ElevatedButton(
              key: const Key('RegisterForm_continue_raisedButton'),
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: const Text('Đăng ký tài khoản',
                      style: TextStyle(color: Colors.white))),
              onPressed: state.status.isValidated
                  ? () async {
                      try {
                        context.read<RegisterBloc>().add(RegisterSubmitted());
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Đăng ký không thành công . Vui lòng thủ lại!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        print(e.toString());
                      }
                    }
                  : null,
            );
          }),
    );
  }
}
