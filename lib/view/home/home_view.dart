import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_feed/res/components/custom_dialog.dart';
import 'package:social_feed/res/constants/app_color.dart';

import '../../../res/components/internet_exceptions_widget.dart';
import '../../../res/constants/value.dart';
import '../../model/Post.dart';
import '../../utils/utils.dart';
import '../../view_model/home/home_view_models.dart';
import '../drawer.dart';
import '../new_post/new_post.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.find();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.userPostJson(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        title: const Text(
          "Social Feed",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        actions: [
          IconButton(
              onPressed: () {
                showCustomDialog(context, "",
                    CreatePostScreen(voidCallback: () {
                  Post post = Post(
                      userId: 1,
                      id: DateTime.timestamp().toString(),
                      userNmae: user!.displayName,
                      title: "title",
                      body: homeController.controller.value.text,
                      photo: homeController.imagePath.value,
                      date: DateFormat('hh:mm:ss').format(DateTime.now()),
                      comments: [],
                      liked: []);
                  homeController.addPost(post);
                  homeController.postList.refresh();
                  Utils.hidePopup();
                }), 0, 0);
              },
              icon: Icon(
                Icons.post_add,
                color: textSecondary,
                size: 30,
              ))
        ],
      ),
      drawer: sideDrawer(context),
      body: Obx(() {
        return homeController.postList.isNotEmpty
            ? ListView.builder(
                itemCount: homeController.postList.length,
                itemBuilder: (ctx, i) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: secondaryBackground,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  user!.photoURL.toString(),
                                  height: 50,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeController.postList[i].userNmae
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: fontMedium,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimary),
                                    ),
                                    Text(
                                      "At " + homeController.postList[i].date,
                                      style: TextStyle(
                                          fontSize: fontMedium,
                                          color: textPrimary),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                    child: SizedBox(width: double.maxFinite)),
                                // IconButton(
                                //     onPressed: () {
                                //
                                //     },
                                //     icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      homeController.postList.removeAt(i);
                                      homeController.postList.refresh();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: textSecondary,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                homeController.postList[i].body,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: fontSmall, color: textPrimary),
                              ),
                            ),
                            const SizedBox(height: 6),
                            homeController.postList[i].photo == ""
                                ? const SizedBox()
                                : Image.file(
                                    File(homeController.postList[i].photo),
                                    height: 160,
                                    width: Size.infinite.width,
                                    fit: BoxFit.fill),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${homeController.postList[i].liked.length} liked",
                                  style: TextStyle(
                                      fontSize: fontSmall, color: textPrimary),
                                ),
                                Text(
                                  "${homeController.postList[i].comments.length} comments",
                                  style: TextStyle(
                                      fontSize: fontSmall, color: textPrimary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    if (homeController
                                            .postList[i].liked.length ==
                                        0) {
                                      homeController.postList[i].liked.add(
                                          Liked(
                                              userId: 1,
                                              userNmae: homeController
                                                  .postList[i].userNmae));
                                    } else {
                                      homeController.postList[i].liked.clear();
                                    }
                                    homeController.postList.refresh();
                                  },
                                  height: 30,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.thumb_up, color: textPrimary),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Like",
                                        style: TextStyle(
                                            fontSize: fontSmall,
                                            color: textPrimary),
                                      )
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    TextEditingController cmtController =
                                        TextEditingController();

                                    showCustomDialog(
                                        context,
                                        "Comments",
                                        commentView(i, cmtController, context,
                                            onPressed: () {
                                          homeController.postList[i].comments
                                              .add(Comments(
                                                  userId: 1,
                                                  userNmae: homeController
                                                      .postList[i].userNmae,
                                                  comment: cmtController.text));
                                          homeController.postList.refresh();
                                          cmtController.clear();
                                        }),
                                        0,
                                        0);
                                  },
                                  height: 30,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.comment, color: textPrimary),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Comment",
                                        style: TextStyle(
                                            fontSize: fontSmall,
                                            color: textPrimary),
                                      )
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  elevation: 0,
                                  onPressed: () {},
                                  height: 30,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.share, color: textPrimary),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                            fontSize: fontSmall,
                                            color: textPrimary),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  );
                })
            : InterNetExceptionWidget(
                onPress: () {
                  print("retry");
                  homeController.userPostJson(context);
                },
              );
      }),
    );
  }
}
