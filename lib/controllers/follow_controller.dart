import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views_features/auth/login_view.dart';

import 'package:http/http.dart' as http;

Future<void> follow(context, {required int id}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  // Map<String, dynamic> data = {'title': title, 'link': link,'username' :user.user?.name};
  int data = id;

  await http.post(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'},
      body: {'followee_id': data.toString()});
}

Future<int> getFollowingCount(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body)['following_count']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['following_count'];

    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<int> getFollowerCount(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body)['followers_count']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['followers_count'];

    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<List> getFollowing(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body)['following']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['following'];

    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<List> getFollower(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(jsonDecode(response.body)['followers']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['followers'];
    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
