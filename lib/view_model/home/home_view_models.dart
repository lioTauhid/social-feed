import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_feed/utils/utils.dart';

import '../../../repository/home_repository/home_repository.dart';
import '../../model/Post.dart';

class HomeViewModel extends GetxController {
  static final User? user = FirebaseAuth.instance.currentUser;
  final _repo = HomeRepository();
  RxInt selectedIndex = 0.obs;
  Rx<TextEditingController> capController = TextEditingController().obs;
  RxString imagePath = "".obs;
  RxBool isLoading = true.obs;

  RxList postList = [].obs;

  // void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  // void setUserList(UserListModel _value) => userList.value = _value ;
  // void setError(String _value) => error.value = _value ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userPostFromDb();
    // addPostToDb();
  }

  void userPostFromJson(BuildContext context) {
    _repo.getPostFromAsset(context).then((value) => postList.value = value);
  }

  void userPostFromDb() {
    _repo.getPostsFromFirebase("posts").then((value) => postList.value = value);
  }

  Future<void> addPostToDb(String caption, String photoPath) async {
    // upload photo and pick url
    String? photoUrl = photoPath.isEmpty ? "" : (await _repo.saveFileToDb(photoPath));

    Post post = Post(
        userId: user!.uid,
        userName: user!.displayName,
        videoUrl: "downloadURL",
        photoUrl: photoUrl,
        caption: caption,
        date: DateTime.now().toString(),
        comments: [],
        liked: []);
    post.id = _repo.savePostToFirebase(post);
    postList.add(post);
    postList.refresh();
    update();
  }

  void addComment(int i, TextEditingController cmt) {
    postList[i].comments.add(Comments(
        userId: user!.uid, userName: user!.displayName, comment: cmt.text));
    postList.refresh();
    _repo.commentToPost(postList[i].id, cmt.text);
    cmt.clear();
  }

  void addLike(int i) {
    if (Utils.findIdByListNearValue(postList[i].liked, user!.uid)) {
      print("Found like");
      postList[i].liked.removeAt(0);
      postList.refresh();
      _repo.reactionToPost(postList[i].id, true);
    } else {
      print("Not Found like");
      postList[i]
          .liked
          .add(Liked(userId: user!.uid, userName: user!.displayName));
      postList.refresh();
      _repo.reactionToPost(postList[i].id, false);
    }
  }
}
