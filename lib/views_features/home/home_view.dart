import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/link_widget.dart';
import '../../constants.dart';
import '../../models/link.dart';
import '../../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;
  getLinksUpdated() async {
    getLinks(context);
    setState(() {});
  }

  @override
  void initState() {
    print("object");
    user = getLocalUser();
    links = getLinks(context);
    getLinksUpdated();
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
            // title
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
                  return const Text("");
                }),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: kPrimaryColor),
              ),
              child: const Image(
                  image: AssetImage("assets/imgs/qr_code.png"),
                  fit: BoxFit.fill),
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
            linkWidget(links: links),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
