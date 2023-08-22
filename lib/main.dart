import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views_features/home/home_view.dart';
import 'package:tt9_betweener_challenge/views_features/links_add_view.dart';
import 'package:tt9_betweener_challenge/views_features/loading/loading_view.dart';
import 'package:tt9_betweener_challenge/views_features/auth/login_view.dart';
import 'package:tt9_betweener_challenge/views_features/main_app_view.dart';
import 'package:tt9_betweener_challenge/views_features/profile_view.dart';
import 'package:tt9_betweener_challenge/views_features/recive/receive_view.dart';
import 'package:tt9_betweener_challenge/views_features/auth/register_view.dart';
import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betweener',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          scaffoldBackgroundColor: kScaffoldColor),
      home: const LoadingView(),
      routes: {
        LoadingView.id: (context) => const LoadingView(),
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        MainAppView.id: (context) => const MainAppView(),
        ProfileView.id: (context) => const ProfileView(),
        ReceiveView.id: (context) => const ReceiveView(),
        LinkAdd.id: (context) => LinkAdd(),
      },
    );
  }
}
