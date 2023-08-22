import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../views_features/auth/login_view.dart';

Future<User> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userFromJson(prefs.getString('user')!);
  }
  return Future.error('not found');
}

Future<List> searchUser(context, String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  String body = name;
  final response = await http.post(Uri.parse(searchUrl),
      body: {'name': body}, headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data['user']);
    return data['user'];
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
