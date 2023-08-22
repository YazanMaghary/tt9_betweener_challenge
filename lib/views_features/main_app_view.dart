import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/controllers/auth_controller.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views_features/home/home_view.dart';
import 'package:tt9_betweener_challenge/views_features/links_add_view.dart';
import 'package:tt9_betweener_challenge/views_features/auth/login_view.dart';
import 'package:tt9_betweener_challenge/views_features/profile_view.dart';
import 'package:tt9_betweener_challenge/views_features/recive/receive_view.dart';
import 'package:tt9_betweener_challenge/views_features/search_profile_view.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/custom_floating_nav_bar.dart';

class MainAppView extends StatefulWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 1;

  late List<Widget?> screensList = [
    const ReceiveView(),
    const HomeView(),
    const ProfileView()
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentIndex == 2
          ? IconButton(
              color: Colors.white,
              style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: kPrimaryColor),
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LinkAdd(0);
                  },
                )).then((value) async {
                  await getLinks(context);
                });
              },
            )
          : null,
      appBar: AppBar(
        leading: _currentIndex == 1
            ? IconButton(
                onPressed: () async {
                  await logout();
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  print(preferences.getString('user'));
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, LoginView.id);
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  size: 24,
                ))
            : const SizedBox(),
        title: _currentIndex == 2
            ? const Text(
                "Profile",
                style: TextStyle(fontSize: 24, color: kPrimaryColor),
              )
            : const Text(""),
        actions: _currentIndex == 0
            ? [const Text("data")]
            : _currentIndex == 1
                ? [
                    IconButton(
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SearchBar(),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 24,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code_outlined,
                          size: 24,
                        )),
                  ]
                : [const Text('')],
        centerTitle: _currentIndex == 2 ? true : false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: screensList[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.close,
          size: 14,
        ),
        splashRadius: 10,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
      splashRadius: 20,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<List> users;

    users = searchUser(context, query);
    // TODO: implement buildSuggestions

    return query == ''
        ? const Text(
            'Write to search about user',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          )
        : FutureBuilder(
            future: users,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileViewSearch(
                              name: snapshot.data?[index]['name'],
                              email: snapshot.data?[index]['email'],
                              links: snapshot.data?[index]['links'] ?? [],
                              idUser: snapshot.data?[index]['id'],
                            );
                          }));
                        },
                        child: Text(
                          "${snapshot.data?[index]['name'] ?? ''}",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ),
                    );
                  });
            });
  }
}
