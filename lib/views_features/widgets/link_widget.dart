// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../models/link.dart';
import '../links_add_view.dart';
import 'add_link_widget.dart';

class linkWidget extends StatefulWidget {
  final Future<List<Link>> links;
  const linkWidget({super.key, required this.links});

  @override
  State<linkWidget> createState() => _linkWidgetState();
}

// ignore: camel_case_types
class _linkWidgetState extends State<linkWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.links,
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
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LinkAdd(0);
                              })).then((value) async {
                                await getLinks(context);
                              });
                            });
                          },
                          child: const add_link_widget(
                            textColor: kPrimaryColor,
                            iconColor: kPrimaryColor,
                            color: kLightPrimaryColor,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            canLaunchUrl(
                                    Uri.parse('${snapshot.data?[index].link}'))
                                .then((value) => {
                                      launchUrl(Uri.parse(
                                          '${snapshot.data?[index].link}'))
                                    });
                          },
                          child: Container(
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
                              )),
                        );
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
                height: 50, child: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Text("");
        });
  }
}
