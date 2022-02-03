
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/my_app.dart';
import 'package:land_app/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () =>  runApp( // Injects the Authentication service
        RepositoryProvider<AuthenticationRepository>(
          create: (context) {
            return AuthenticationRepository();
          },
          child: MyApp(appRouter: AppRouter()),
          )),
    storage: storage,
  );

 
}
