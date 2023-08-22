import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

class ProfileViewSearch extends StatefulWidget {
  static String id = '/ProfileViewSearch';
  final String name;
  final String email;
  final int idUser;
  final List links;
  ProfileViewSearch(
      {super.key,
      required this.name,
      required this.email,
      required this.links,
      required this.idUser});

  @override
  State<ProfileViewSearch> createState() => _ProfileViewSearchState();
}

class _ProfileViewSearchState extends State<ProfileViewSearch> {
  late Future<User> user;
  late Future<int> follower;
  late Future<int> following;
  late Future<List<Link>> links;
  bool isFollowed = false;
  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    follower = getFollowingCount(context);
    following = getFollowerCount(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                // padding:
                //     const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/imgs/avatar.png"),
                              fit: BoxFit.fill)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.email,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kSecondaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              follow(context, id: widget.idUser);
                              isFollowed = true;
                              setState(() {});
                            },
                            onDoubleTap: () {
                              isFollowed = false;
                              setState(() {});
                            },
                            child: Text(
                              isFollowed == false ? 'follow' : 'followed',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 14,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.links.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor:
                        index % 2 == 0 ? kLightDangerColor : kLightPrimaryColor,
                    title: Text(
                      '${widget.links[index]['title']}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: index % 2 == 0
                              ? kOnLightDangerColor
                              : kPrimaryColor),
                    ),
                    subtitle: Text(
                      '${widget.links[index]['link']}',
                      style: TextStyle(
                          fontSize: 14,
                          color: index % 2 == 0
                              ? kOnLightDangerColor
                              : kLinksColor),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
// 96 add test