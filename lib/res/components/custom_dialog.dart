import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_feed/res/components/common_widgets.dart';
import '../../../utils/utils.dart';
import '../../model/Post.dart';
import '../../view_model/home/home_view_models.dart';
import '../constants/app_color.dart';
import '../constants/value.dart';

Future<void> showCustomDialog(BuildContext context, String title, Widget widget,
    int heightReduce, int widthReduce) async {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width - widthReduce,
            height: MediaQuery.of(context).size.height - heightReduce,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryBackground,
            ),
            child: Column(
              children: [
                // dialogHeader(title, context),
                // Divider(color: textSecondary, thickness: 1),
                // const SizedBox(height: 10),
                Expanded(
                  child: widget,
                ),
              ],
            ),
          ));
    },
  );
}

Widget dialogHeader(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: textPrimary),
        ),
        IconButton(
          onPressed: () {
            Utils.hidePopup();
          },
          icon: Icon(
            Icons.close,
            color: textSecondary,
          ),
        ),
      ],
    ),
  );
}

Widget commentView(
    int index, TextEditingController controller, BuildContext context,
    {Function()? onPressed}) {
  final HomeController homeController = Get.find();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        dialogHeader("Comments", context),
        const SizedBox(height: 10),
        TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: fontSmall, color: textPrimary),
            decoration: InputDecoration(
              fillColor: secondaryBackground,
              suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.send, color: primaryColor)),
              hintText: "Write comment here...",
              hintStyle: TextStyle(color: textSecondary),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: textPrimary, style: BorderStyle.solid)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )),
        Expanded(
          child: Obx(() {
            return ListView.builder(
                itemCount: homeController.postList[index].comments.length,
                itemBuilder: (ctx, i) {
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: textPrimary,
                    ),
                    title: Text(
                        homeController.postList[index].comments[i].userNmae
                            .toString(),
                        style: TextStyle(color: textPrimary)),
                    subtitle: Text(
                      homeController.postList[index].comments[i].comment
                          .toString(),
                      style: TextStyle(color: textPrimary),
                    ),
                  );
                });
          }),
        )
      ],
    ),
  );
}

Widget about(context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            scale: 1,
          ),
          Text(
            '$appName $appVersion',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            ('DevInfo'),
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            ('Lio System Inc'),
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: textPrimary),
          ),
          TextField(
              controller: TextEditingController(text: "liotauhid@gmail.com"),
              style: TextStyle(color: textSecondary)),
          TextField(
              controller:
                  TextEditingController(text: "https://github.com/lioTauhid"),
              style: TextStyle(color: textSecondary)),
          TextField(
              controller: TextEditingController(
                  text: "https://www.linkedin.com/in/md-tauhid-5861b8140"),
              style: TextStyle(color: textSecondary)),
          // TextField(
          //     controller: TextEditingController(
          //         text:
          //             "https://play.google.com/store/apps/developer?id=Lio+system+inc"),
          //     style: TextStyle(color: textSecondary))
        ],
      ),
    ],
  );
}
