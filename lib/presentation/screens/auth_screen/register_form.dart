// import 'package:flutter/material.dart';
// import 'package:maico_land/bloc/register_bloc/register_bloc.dart';
// import 'package:maico_land/model/repositories/user_repository.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maico_land/model/repositories/user_repository.dart';
// import 'package:maico_land/presentation/styles/app_colors.dart';
// import 'package:maico_land/presentation/styles/theme.dart';
// import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';

// class RegisterForm extends StatefulWidget {
//   const RegisterForm({required this.userRepo, Key? key}) : super(key: key);
//   final UserRepository userRepo;

//   @override
//   _RegisterFormState createState() => _RegisterFormState(userRepo);
// }

// class _RegisterFormState extends State<RegisterForm> {
//   final UserRepository userRepo;
//   _RegisterFormState(this.userRepo);
//   final _registerFormKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();

//   bool rememberMe = false;

//   // get size => Media?

//   @override
//   Widget build(BuildContext context) {
//     _onRegisterButtonPressed() {
//       BlocProvider.of<RegisterBloc>(context).add(RegisterSubmitted());
//     }

//     return 
//        BlocListener<RegisterBloc, RegisterState>(
//           listener: (context, state) {
//         // if (state is RegisterFailure) {
//         //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         //       content: Text('Đăng nhập thất bại'), backgroundColor: Colors.red));
//         // }
//       }, child: BlocBuilder<RegisterBloc, RegisterState>(
//         builder: (context, state) {
//           return SingleChildScrollView(
//             child: Center(
//               child: Padding(
//                   padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                   child: _buildContent()),
//             ),
//           );
//         },
//       )
//     );
//   }

//   Widget _buildContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             _FirstNameInput(_firstNameController),
//           ],
//         )
//         // _NewsAddButton(),
//       ],
//     );
//   }
// }

// class _FirstNameInput extends StatelessWidget {
//   TextEditingController controller;
//   _FirstNameInput(this.controller);
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterBloc, RegisterState>(
//         buildWhen: (previous, current) =>
//             previous.firstName != current.firstName,
//         builder: (context, state) {
//           return TextField(
//             controller: controller,
//             key: const Key('RegisterForm_FirstNameInput_textField'),
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.black26),
//                 borderRadius: BorderRadius.circular(4.0),
//               ),
//               alignLabelWithHint: true,
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   borderSide: BorderSide(color: AppColors.appGreen1)),
//               labelText: "Họ",
//               focusedErrorBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   borderSide: BorderSide(color: AppColors.red)),
//               errorBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   borderSide: BorderSide(color: AppColors.red)),
//               errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
//               focusColor: AppColors.appGreen1,
//               errorText: state.firstName.invalid
//                   ? 'Vui lòng nhập trên 4 kí tự !'
//                   : null,
//               contentPadding: const EdgeInsets.only(
//                 top: 10.0,
//                 left: 10.0,
//                 right: 10.0,
//               ),
//             ),
//           );
//         });
//   }
// }
