import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/Post.dart';
import '../../service/local/read_file.dart';
import '../../service/network/firestore.dart';
import '../../utils/utils.dart';
import '../../view_model/home/home_view_models.dart';

class HomeRepository {
  // final _apiService  = NetworkApiServices() ;
  final FirebaseService firebaseService = FirebaseService();

  // Future<UserListModel> userListApi() async{
  //   dynamic response = await _apiService.getApi(AppUrl.userListApi);
  //   return UserListModel.fromJson(response) ;
  // }

  String? savePostToFirebase(Post post) {
    String? id = firebaseService.saveDataCollection("posts", post);
    return id;
  }

  Future<String?> saveFileToDb(String localFilePath) async {
    String? url = await firebaseService.uploadFileToFirebase(localFilePath);
    return url;
  }

  Future<List<Post>> getPostsFromFirebase(String path) async {
    var docs = await firebaseService.getDataCollection(path);
    List<Post> list = [];
    for (var p in docs) {
      Post post = Post.fromJson(p.data());
      post.id = p.id;
      list.add(post);
    }
    return list;
  }

  Future<List<Post>> getPostFromAsset(BuildContext context) async {
    final readFileService = ReadFile();
    final jsonResult = await readFileService.readAssetsJson(context);
    List<Post> posts = [];
    for (var p in jsonResult) {
      Post post = Post.fromJson(p);
      posts.add(post);
    }
    return posts;
  }

  void commentToPost(String id, String cmt) {
    FirebaseService.db.collection("posts").doc(id).update({
      "comments": FieldValue.arrayUnion([
        Comments(
                userId: FirebaseService.user!.uid,
                userName: FirebaseService.user!.displayName,
                comment: cmt)
            .toJson()
      ])
    });
  }

  void reactionToPost(String id, bool isLiked) {
    if (isLiked) {
      FirebaseService.db.collection("posts").doc(id).update({
        "liked": FieldValue.arrayRemove([
          Liked(
                  userId: FirebaseService.user!.uid,
                  userName: FirebaseService.user!.displayName)
              .toJson()
        ])
      });
    } else {
      FirebaseService.db.collection("posts").doc(id).update({
        "liked": FieldValue.arrayUnion([
          Liked(
                  userId: FirebaseService.user!.uid,
                  userName: FirebaseService.user!.displayName)
              .toJson()
        ])
      });
    }
  }
}
