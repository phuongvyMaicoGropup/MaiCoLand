import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:maico_land/bloc/login_bloc/login.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/styles/theme.dart';
import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.userRepo, Key? key}) : super(key: key);
  final UserRepository userRepo;

  @override
  _LoginFormState createState() => _LoginFormState(userRepo);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepo;
  _LoginFormState(this.userRepo);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  // get size => Media?

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          rememberMe: rememberMe));
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Tên đăng nhập hoặc mật khẩu sai . Vui lòng thử lại !'),
            backgroundColor: AppColors.appErrorRed));
      }
      if (state is LoginSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 224, 223, 223),
              )),
              Positioned(
                child: Container(
                    decoration: boxBorderWhite,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    child: Form(
                      child: Column(
                        children: [
                          Image(
                              image: const AssetImage('assets/logo.png'),
                              height: MediaQuery.of(context).size.height * 0.2),
                          const SizedBox(height: 10),
                          WidgetInputTextField(
                            inputType: TextInputType.name,
                            icon: EvaIcons.people,
                            visiblePassword: false,
                            labelText: "Tên đăng nhập",
                            inputController: _usernameController,
                          ),
                          const SizedBox(height: 10),
                          WidgetInputTextField(
                            inputType: TextInputType.visiblePassword,
                            visiblePassword: true,
                            icon: EvaIcons.eyeOutline,
                            labelText: "Mật khẩu",
                            inputController: _passwordController,
                          ),
                          const SizedBox(height: 15),
                          Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  child: const Text('Quên mật khẩu!',
                                      style: AppTextTheme.minorTextBlack),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/forgetpassword");
                                  })),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Column(children: [
                              SizedBox(
                                  height: 50,
                                  child: state is LoginLoading
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Center(
                                                child: SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child:
                                                        CupertinoActivityIndicator()))
                                          ],
                                        )
                                      : TextButton(
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: const Text("Đăng nhập")),
                                          onPressed: () {
                                            _onLoginButtonPressed();
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                AppColors.appGreen1,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 8),
                                          ),
                                        ))
                            ]),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Chưa có tài khoản ? ",
                                        style: textMinorBlack),
                                    GestureDetector(
                                        child: const Text("Đăng ký ngay",
                                            style: textMinorItalicGreen),
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                              context, "/register");
                                        }),
                                  ]))
                        ],
                      ),
                    )),
              )
            ],
          )),
        );
      },
    ));
  }
}
