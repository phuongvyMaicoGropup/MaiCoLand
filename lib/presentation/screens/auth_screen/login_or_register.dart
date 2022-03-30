import 'package:flutter/material.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                child: Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(255, 224, 223, 223),
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
                        const Text("Wellcome", style: textLargeBlack),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            "Hãy đăng nhập hoặc đăng kí để sử dụng dịch vụ của chúng tôi!",
                            style: textMinorGreen),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      child: const Text('Đăng Nhập',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      key: const Key(
                                          'LoginOraRegister_submitField'),
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/login");
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                      child: const Text("Đăng kí",
                                          style: textMediumGreen),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/register",
                                        );
                                      }),
                                ]))
                      ],
                    ),
                  )),
            )
          ],
        )),
      ),
    );
  }
}
