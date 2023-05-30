import 'dart:convert';

import 'package:youapp_test/helper/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:youapp_test/models/profile_model.dart';
import 'package:youapp_test/models/user_model.dart';

abstract class BaseApiRepository {
  Stream auth(String token);
  Future<User> login(String email, String password);
  Stream loadProfile(String token, String email);
  Future updateProfile(String token, String email, Profile profile);
}

class ApiRepository extends BaseApiRepository {
  final url = 'http://10.0.2.2:3000/api';
  final headers = {"Content-Type": "application/json"};
  Map<String, String> headersWithToken(String token) => {
        "Content-Type": "application/json",
        ApiHelper.authorization: 'Bearer $token'
      };

  Future<User> register(String username, String email, String password) async {
    String body =
        '{ "${ApiHelper.username}": "$username", "${ApiHelper.email}": "$email", "${ApiHelper.password}": "$password" }';

    try {
      http.Response response = await http.post(Uri.parse('$url/register'),
          body: body, headers: headers);
      var data = json.decode(response.body);
      print(data);
      return User.register(data, username, email, password);
    } catch (err) {
      print('test $err');
      return User.empty();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    final body =
        '{ "${ApiHelper.email}": "$email", "${ApiHelper.password}": "$password" }';

    try {
      http.Response response = await http.post(Uri.parse('$url/login'),
          body: body, headers: headers);
      var data = json.decode(response.body);
      return User.login(data, email, password);
    } catch (err) {
      // print('test $err');
      return User.empty();
    }
  }

  Future<String> authCheck(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$url/authCheck'),
        headers: headersWithToken(token),
      );
      var data = json.decode(response.body);
      return data[ApiHelper.message];
    } catch (err) {
      return 'Unauthorized';
    }
  }

  @override
  Stream auth(String token) async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return authCheck(token);
    }).asyncMap((event) async => await event);
  }

  Future<Profile> getProfile(String token, String email) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$url/getProfile/$email'),
          headers: headersWithToken(token));
      var data = json.decode(response.body);
      return Profile.fromJson(data);
    } catch (err) {
      print(err);
      return Profile.empty();
    }
  }

  @override
  Stream loadProfile(String token, String email) async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return getProfile(token, email);
    }).asyncMap((event) async => await event);
  }

  @override
  Future updateProfile(String token, String email, Profile profile) async {
    final newHeader = {ApiHelper.authorization: 'Bearer $token'};
    try {
      print(profile.toJson());
      http.Response response = await http.put(
        Uri.parse('$url/updateProfile/$email'),
        headers: headersWithToken(token),
        body: jsonEncode(profile.toJson()),
      );
    } catch (err) {
      print('test $err');
    }
  }
}
