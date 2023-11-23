import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_feed/res/components/custom_dialog.dart';
import 'package:social_feed/res/constants/app_color.dart';

import '../../../res/components/internet_exceptions_widget.dart';
import '../../../res/constants/value.dart';
import '../../model/Post.dart';
import '../../res/components/common_widgets.dart';
import '../../utils/utils.dart';
import '../../view_model/home/home_view_models.dart';
import 'drawer.dart';
import '../new_post/new_post.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeController = Get.find();

  void showComment(int index) {
    TextEditingController cmtController = TextEditingController();
    showCustomDialog(
        context,
        "Comments",
        commentView(index, cmtController, context, onPressed: () {
          homeController.addComment(index, cmtController);
        }),
        0,
        0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBackground,
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 40,
          elevation: 0,
          leadingWidth: 50,
          title: const Row(
            children: [
              // Image.asset("assets/Group 946.png"),
              Icon(FontAwesomeIcons.facebook, color: secondaryColor),
              SizedBox(width: 8),
              Text(
                " Social Feed",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: fontMedium,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                    color: secondaryColor, size: 20)),
            IconButton(
                onPressed: () {
                  homeController.postList.clear();
                  homeController.userPostFromDb();
                },
                icon: const Icon(FontAwesomeIcons.arrowsRotate,
                    color: secondaryColor, size: 20)),
            IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.bell,
                    color: secondaryColor, size: 20)),
            const SizedBox(width: 20)
          ],
        ),
        drawer: sideDrawer(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: MaterialButton(
                onPressed: () {
                  showCustomDialog(
                      context,
                      "Create post",
                      CreatePostScreen(
                        voidCallback: () {},
                      ),
                      0,
                      0);
                },
                height: 50,
                padding: const EdgeInsets.all(10),
                color: secondaryBackground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.penToSquare,
                      color: textPrimary,
                    ),
                    SizedBox(width: 20),
                    Text("What on your mind...",
                        style: TextStyle(
                            fontSize: fontMedium, color: textSecondary)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return homeController.postList.isNotEmpty
                    ? ListView.builder(
                        itemCount: homeController.postList.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: secondaryBackground,
                                  // border: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.userLarge,
                                        color: textPrimary,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController.postList[i].userName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: fontMedium,
                                                fontWeight: FontWeight.bold,
                                                color: textPrimary),
                                          ),
                                          Text(
                                            "At " +
                                                homeController.postList[i].date
                                                    .split('.')
                                                    .first,
                                            style: TextStyle(
                                                fontSize: fontMedium,
                                                color: textPrimary),
                                          ),
                                        ],
                                      ),
                                      const Expanded(
                                          child: SizedBox(
                                              width: double.maxFinite)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.ellipsis,
                                            color: textSecondary,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            homeController.postList.removeAt(i);
                                            homeController.postList.refresh();
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: textSecondary,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      homeController.postList[i].caption,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: textPrimary),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  homeController.postList[i].photoUrl == ""
                                      ? const SizedBox()
                                      : Image.network(
                                          homeController.postList[i].photoUrl
                                              .toString(),
                                          height: 160,
                                          width: Size.infinite.width,
                                          fit: BoxFit.fill),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          showCustomDialog(
                                              context,
                                              "Liked Peoples",
                                              ListView.builder(
                                                  itemCount: homeController
                                                      .postList[i].liked.length,
                                                  itemBuilder: (c, index) {
                                                    return ListTile(
                                                        leading: const Icon(
                                                          FontAwesomeIcons.user,
                                                          color: primaryColor,
                                                        ),
                                                        trailing: const Icon(
                                                          Icons.thumb_up,
                                                          color: primaryColor,
                                                        ),
                                                        title: Text(
                                                          homeController
                                                                  .postList[i]
                                                                  .liked[index]
                                                                  .userName ??
                                                              "Unnamed",
                                                          style: TextStyle(
                                                              color:
                                                                  textPrimary),
                                                        ));
                                                  }),
                                              MediaQuery.of(context)
                                                      .size
                                                      .height ~/
                                                  2,
                                              30);
                                        },
                                        height: 10,
                                        minWidth: 50,
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          "${homeController.postList[i].liked.length} liked",
                                          style: TextStyle(
                                              fontSize: fontSmall,
                                              color: textPrimary),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          showComment(i);
                                        },
                                        height: 10,
                                        minWidth: 80,
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          "${homeController.postList[i].comments.length} comments",
                                          style: TextStyle(
                                              fontSize: fontSmall,
                                              color: textPrimary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaterialButton(
                                        elevation: 0,
                                        onPressed: () {
                                          homeController.addLike(i);
                                        },
                                        height: 30,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.thumb_up,
                                                color: textPrimary),
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
                                          showComment(i);
                                        },
                                        height: 30,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.comment,
                                                color: textPrimary),
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
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.share,
                                                color: textPrimary),
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
                              ));
                        })
                    : homeController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : InterNetExceptionWidget(
                            onPress: () {
                              print("retry");
                              homeController.userPostFromDb();
                            },
                          );
              }),
            ),
          ],
        ));
  }
}
