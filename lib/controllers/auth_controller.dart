import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<User> login(Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<User> register(Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(registerUrl),
    body: body,
  );

  if (response.statusCode == 201) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
