import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_feed/res/components/common_widgets.dart';
import 'package:social_feed/res/constants/value.dart';
import 'package:social_feed/utils/utils.dart';

import '../../../res/constants/app_color.dart';
import '../../view_model/home/home_view_models.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key, required this.voidCallback}) : super(key: key);
  final HomeController homeController = Get.find();
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        title: const Text(
          "Create Post",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBackground,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                elevation: 0,
                color: secondaryColor,
                onPressed: voidCallback,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(color: white, fontSize: fontSmall),
                )),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Utils.hidePopup();
            },
            icon: Icon(Icons.arrow_back_ios, color: textPrimary)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                  controller: homeController.controller.value,
                  keyboardType: TextInputType.text,
                  minLines: 6,
                  maxLines: 6,
                  style: TextStyle(fontSize: fontSmall, color: textPrimary),
                  decoration: InputDecoration(
                    fillColor: secondaryBackground,
                    hintText: 'Tell your circle what\'s happening.',
                    hintStyle: TextStyle(color: textSecondary),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: textPrimary,
                            style: BorderStyle.solid)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: textPrimary,
                            style: BorderStyle.solid)),
                  )),
              SizedBox(height: 10),
              Obx(() {
                return homeController.imagePath.isEmpty
                    ? const SizedBox()
                    : Image.file(File(homeController.imagePath.value));
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconTextBtn(
                      Icon(
                        Icons.photo,
                        color: textPrimary,
                      ),
                      "Add Photo",
                      Colors.transparent,
                      textPrimary,
                      fontSmall, onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      homeController.imagePath.value = image.path;
                    } else {
                      Utils.showSnackBar("Error picking image!");
                    }
                  }),
                  iconTextBtn(
                      const Icon(Icons.delete_forever, color: red),
                      "Remove Photo",
                      Colors.transparent,
                      textPrimary,
                      fontSmall, onPressed: () {
                    homeController.imagePath.value = "";
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
