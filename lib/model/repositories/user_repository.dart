import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maico_land/helpers/jwt_parse.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/responses/user_reponse.dart';

class UserRepository {
  final DioProvider dio_provider = DioProvider();

  Future<String> hasToken() async {
    var value = await dio_provider.storage.read(key: "token");
    if (value != null) {
      return Future<String>.value(value);
    } else
      return Future<String>.value("");
  }

  Future<void> persisteToken(String token) async {
    await dio_provider.storage.write(key: "token", value: token);
  }

  Future<void> deleteToken() async {
    dio_provider.storage.delete(key: "token");
    dio_provider.storage.deleteAll();
  }
  
  Future<String> login(
      String username, String password, bool rememberMe) async {
    Response response = await dio_provider.dio.post(dio_provider.loginUrl,
        data: {
          'userName': username,
          'password': password,
          'rememberMe': rememberMe
        });

    return Future<String>.value(response.data["token"]);
  }

  Future<String> register(
      {
      required String firstName,
      required String lastName,
      required String username,
      required String email,
      required String password}) async {
    Response response =
        await dio_provider.dio.get(dio_provider.registerUrl, queryParameters: {
      "firstName": firstName,
      "lastName": lastName,
      "userName": username,
      "email": email,
      "password": password,
      "rememberMe": true
    });
    return Future<String>.value(response.data.toString());
  }

  User getUserInfo(String token) {
    JWTParse jwt = JWTParse();
    var user = jwt.parseJwt(token);
    print(user);
    User userReponse = User(
      userName: user['username'],
      email: user['email'],
      id: user['id'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      phoneNumber: user['phoneNumber'],
      photoURL: user['photoURL'],
    );
    // UserReponse userReponse = UserReponse(
    //   username: 'username',

    //   email: 'email',
    //   id: 'id',
    //   firstName: 'firstName',
    //   lastName: 'lastName',
    //   phoneNumber: 'phoneNumber',
    //   photoURL: 'photoURL',
    // );
    return userReponse;
  }
}
