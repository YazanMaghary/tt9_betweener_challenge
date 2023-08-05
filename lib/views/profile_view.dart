import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/views/links_add_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> user;
  late Future<int> follower;
  late Future<int> following;
  late Future<List> followerNames;
  late Future<List> followingNames;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    follower = getFollowerCount(context);
    following = getFollowingCount(context);
    followerNames = getFollower(context);
    followingNames = getFollowing(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 28, horizontal: 20),
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
                          width: 12,
                        ),
                        FutureBuilder(
                            future: user,
                            builder: (context, snapshot) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data?.user?.name}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${snapshot.data?.user?.email}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  FutureBuilder(
                                    future: follower,
                                    builder: (context, snapshot2) {
                                      if (snapshot2.hasData) {
                                        return Row(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: kSecondaryColor,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                child: FutureBuilder(
                                                  future: follower,
                                                  builder:
                                                      (context, snapshot2) {
                                                    if (snapshot2.hasData) {
                                                      return InkWell(
                                                        onTap: () {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                  dismissDirection:
                                                                      DismissDirection
                                                                          .vertical,
                                                                  backgroundColor:
                                                                      kPrimaryColor,
                                                                  content:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    color:
                                                                        kPrimaryColor,
                                                                    height: 400,
                                                                    child:
                                                                        FutureBuilder(
                                                                      future:
                                                                          followerNames,
                                                                      builder: (BuildContext
                                                                              context,
                                                                          AsyncSnapshot<dynamic>
                                                                              snapshot) {
                                                                        return ListView.builder(
                                                                            itemCount: snapshot.data?.length,
                                                                            itemBuilder: (context, index) {
                                                                              return Center(
                                                                                child: Text(
                                                                                  "${snapshot.data?[index]['name']}",
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                ),
                                                                              );
                                                                            });
                                                                      },
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Text(
                                                          'followers ${snapshot2.data}',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      );
                                                    }
                                                    if (snapshot2.hasError) {
                                                      return Text(
                                                          '${snapshot2.error}');
                                                    }
                                                    if (snapshot2
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const SizedBox(
                                                          height: 5,
                                                          width: 5,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    }
                                                    return const SizedBox(
                                                        height: 5,
                                                        width: 5,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                                  },
                                                )),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: kSecondaryColor,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                child: FutureBuilder(
                                                  future: following,
                                                  builder:
                                                      (context, snapshot3) {
                                                    if (snapshot3.hasData) {
                                                      return InkWell(
                                                        onTap: () {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                  dismissDirection:
                                                                      DismissDirection
                                                                          .vertical,
                                                                  backgroundColor:
                                                                      kPrimaryColor,
                                                                  content:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    color:
                                                                        kPrimaryColor,
                                                                    height: 400,
                                                                    child:
                                                                        FutureBuilder(
                                                                      future:
                                                                          followingNames,
                                                                      builder: (BuildContext
                                                                              context,
                                                                          AsyncSnapshot<dynamic>
                                                                              snapshot) {
                                                                        return ListView.builder(
                                                                            itemCount: snapshot.data?.length,
                                                                            itemBuilder: (context, index) {
                                                                              return Center(
                                                                                child: Text(
                                                                                  "${snapshot.data?[index]['name']}",
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                ),
                                                                              );
                                                                            });
                                                                      },
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Text(
                                                          'following ${snapshot3.data}',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      );
                                                    }
                                                    if (snapshot3.hasError) {
                                                      return Text(
                                                          "${snapshot3.error}");
                                                    }
                                                    if (snapshot3
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const SizedBox(
                                                          height: 5,
                                                          width: 5,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator()));
                                                    }
                                                    return const SizedBox(
                                                        height: 5,
                                                        width: 5,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                                  },
                                                )),
                                          ],
                                        );
                                      }
                                      if (snapshot2.hasError) {
                                        return Text('${snapshot2.error}');
                                      }
                                      return const SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()));
                                    },
                                  )
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                  Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ))
                ]),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 14,
              child: FutureBuilder(
                  future: links,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Slidable(
                                  direction:
                                      axisDirectionToAxis(AxisDirection.right),
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    dragDismissible: false,
                                    motion: const ScrollMotion(),
                                    // A pane can dismiss the Slidable.
                                    dismissible: DismissiblePane(
                                        closeOnCancel: true,
                                        onDismissed: () {
                                          setState(() {
                                            snapshot.data?.removeAt(index);
                                          });
                                        }),
                                    children: [
                                      SlidableAction(
                                        flex: 5,
                                        borderRadius: BorderRadius.circular(20),
                                        onPressed: (value) {
                                          deleteLink(context,
                                              snapshot.data?[index].id as int);
                                          snapshot.data?.removeAt(index);
                                          setState(() {});
                                        },
                                        backgroundColor: kRedColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      SlidableAction(
                                        flex: 5,
                                        borderRadius: BorderRadius.circular(20),
                                        onPressed: (value) {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LinkAdd(
                                                1,
                                                snapshot.data?[index].id,
                                                snapshot.data?[index].link,
                                                snapshot.data?[index].title);
                                          }));
                                        },
                                        backgroundColor: kSecondaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: index % 2 == 0
                                        ? kLightDangerColor
                                        : kLightPrimaryColor,
                                    title: Text(
                                      '${snapshot.data?[index].title}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: index % 2 == 0
                                              ? kOnLightDangerColor
                                              : kPrimaryColor),
                                    ),
                                    subtitle: Text(
                                      '${snapshot.data?[index].link}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: index % 2 == 0
                                              ? kOnLightDangerColor
                                              : kLinksColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Text('data');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()));
                    }
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Text("");
                  }))
        ],
      ),
    );
  }
}
