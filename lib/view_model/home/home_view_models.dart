
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/home_repository/hone_repository.dart';
import '../../model/Post.dart';

class HomeController extends GetxController {

  final _repo = HomeRepository();
  RxInt selectedIndex = 0.obs;
  Rx<TextEditingController> controller = TextEditingController().obs;
  RxString imagePath = "".obs;



  // final rxRequestStatus = Status.LOADING.obs ;
  // final userList =UserListModel().obs ;
  RxString error = ''.obs;
  RxList postList = [].obs;

  // void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  // void setUserList(UserListModel _value) => userList.value = _value ;
  // void setError(String _value) => error.value = _value ;


  void userPostJson(BuildContext context){
    _repo.getPostFromAsset(context).then((value) => postList.value= value);

  }

  void addPost(Post post){
    postList.add(post);
    postList.refresh();
    update();
  }

}