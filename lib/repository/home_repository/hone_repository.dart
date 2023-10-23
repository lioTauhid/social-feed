
import 'package:flutter/cupertino.dart';

import '../../model/Post.dart';
import '../../service/local/read_file.dart';

class HomeRepository {
  // final _apiService  = NetworkApiServices() ;
  final _readFileService = ReadFile();

  // Future<UserListModel> userListApi() async{
  //   dynamic response = await _apiService.getApi(AppUrl.userListApi);
  //   return UserListModel.fromJson(response) ;
  // }

  Future<List<Post>> getPostFromAsset(BuildContext context) async {
    final jsonResult = await _readFileService.readAssetsJson(context);
    List<Post> posts = [];
    for (var p in jsonResult) {
      Post post = Post.fromJson(p);
      posts.add(post);
    }
    return posts;
  }
}
