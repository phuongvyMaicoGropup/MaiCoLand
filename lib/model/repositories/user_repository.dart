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
    try {
      Response response = await dio_provider.dio.post(dio_provider.loginApi,
          data: {
            'userName': username,
            'password': password,
            'rememberMe': rememberMe
          });

      return Future<String>.value(response.data["token"]);
    } catch (e) {
      print("Loix login");
      print(e);
      return Future<String>.value("");
    }
  }

  Future<bool> register(
      {required String firstName,
      required String lastName,
      required String username,
      required String email,
      required String phoneNumber,
      required String password}) async {
    try {
      print(email + firstName + lastName + username + password);
      Response response =
          await dio_provider.dio.post(dio_provider.registerApi, data: {
        "fullName": firstName + " " + lastName,
        "userName": username,
        "phoneNumber": phoneNumber,
        "password": password,
        "email": email,
      });
      print("Đăng ký");
      print(response.data);
      return Future<bool>.value(true);
    } catch (e) {
      print("Looix cuar register repo");
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future<bool> changePassword(
      {required String phoneNumber, required String password}) async {
    try {
      Response response = await dio_provider.dio
          .post(dio_provider.forgotpassswordAcount, data: {
        "phoneNumber": phoneNumber,
        "password": password,
      });
      return Future<bool>.value(true);
    } catch (e) {
      print("Looix cuar register repo");
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future<String> getUserId() async {
    var token = await hasToken();
    return jwt.parseJwt(token)['id'];
  }

  User getUserInfo(String token) {
    var user = jwt.parseJwt(token);
    print(user);

    User userReponse = User(
      userName: user['userName'],
      email: user['email'],
      id: user['id'],
      fullName: user['fullName'],
      phoneNumber: user['phoneNumber'],
      photoURL: user['photoURL'],
      address: user['address'],
      bio: user['bio'],
      birthDate: DateTime.tryParse(user['birthDate']) ?? DateTime.now(),
    );
    return userReponse;
  }

  Future<User?> getUserById(String id) async {
    try {
      Response response = await dio_provider.dio.get(
        dio_provider.baseUrl + "api/user/" + id,
      );
      print(response.data);

      return Future<User>.value(User.fromJson(response.data));
    } catch (e) {
      print(e);
      return Future<User>.value(null);
    }
  }

  Future<String> getNameByPhone(String phone) async {
    try {
      Response response = await dio_provider.dio.get(
          dio_provider.checkPhoneAcount,
          queryParameters: {"phone": phone});

      return response.data;
    } catch (e) {
      return "";
    }
  }
  // Future<bool > updateAvatar()
}
