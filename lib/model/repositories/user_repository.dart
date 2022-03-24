import 'package:dio/dio.dart';
import 'package:maico_land/helpers/jwt_parse.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/user.dart';

class UserRepository {
  final DioProvider dio_provider = DioProvider();
  final JWTParse jwt = JWTParse();

  Future<String> hasToken() async {
    var value = await dio_provider.storage.read(key: "token");
    if (value != null) {
      return Future<String>.value(value);
    } else {
      return Future<String>.value("");
    }
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
    Response response = await dio_provider.dio.post(dio_provider.loginApi,
        data: {
          'userName': username,
          'password': password,
          'rememberMe': rememberMe
        });
    if (response.statusCode != 200) {
      return Future<String>.value("");
    }
    return Future<String>.value(response.data["token"]);
  }

  Future<String> register(
      {required String firstName,
      required String lastName,
      required String username,
      required String email,
      required String password}) async {
    Response response =
        await dio_provider.dio.get(dio_provider.registerApi, queryParameters: {
      "firstName": firstName,
      "lastName": lastName,
      "userName": username,
      "email": email,
      "password": password,
      "rememberMe": true
    });
    return Future<String>.value(response.data.toString());
  }

  Future<String> getUserId() async {
    var token = await hasToken();
    return jwt.parseJwt(token)['id'];
  }

  User getUserInfo(String token) {
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
    return userReponse;
  }

  Future<User> getUserById(String id) async {
    try {
      Response response = await dio_provider.dio.get(
          dio_provider.baseUrl + "api/user/" + id,
          queryParameters: {"id": id});
      print(response.data);

      return Future<User>.value(User.fromMap(response.data));
    } catch (e) {
      print(e);
      return Future<User>.value(null);
    }
  }
  // Future<bool > updateAvatar()
}
