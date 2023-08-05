import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  // get link api url
  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<void> addLink(context, String title, String link) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  // Map<String, dynamic> data = {'title': title, 'link': link,'username' :user.user?.name};
  Map<String, dynamic> data = {
    'title': title,
    'userId': '${user.user?.id}',
    'link': link,
    'username': user.user?.name,
    'isActive': "1"
  };

  await http.post(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: data);
}

Future<void> deleteLink(context, int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  await http.delete(
    Uri.parse("$linksUrl/$id"),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
}

Future<void> updateLink(context, int id, String title, String link) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user').toString());
  Map<String, dynamic> data = {
    'title': title,
    'userId': '${user.user?.id}',
    'link': link,
    'username': user.user?.name,
    'isActive': "1"
  };
  await http.put(
    Uri.parse("$linksUrl/$id"),
    body: data,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
}
