import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/links_add_view.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Hello, ${snapshot.data?.user?.name}",
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return Text("");
                }),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: kPrimaryColor),
              ),
              child: const Image(image: AssetImage("assets/imgs/qr_code.png")),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Divider(
                thickness: 3,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: links,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 100,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          return index == snapshot.data!.length
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LinkAdd(0);
                                    }));
                                    setState(() {});
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: kLightPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 32,
                                            color: kPrimaryColor,
                                          ),
                                          Text(
                                            "Add Link",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${snapshot.data?[index].title}",
                                        style: const TextStyle(
                                            color: kOnSecondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "@${snapshot.data?[index].username}",
                                        style: const TextStyle(
                                          color: kOnSecondaryColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 8,
                          );
                        },
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Text("");
                })
          ],
        ),
      ),
    );
  }
}
