import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_feed/res/constants/app_color.dart';
import '../../../res/components/common_widgets.dart';
import '../../../res/routes/routes_name.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 38,
                    ),
                  ),
                  const Text(
                    'Login now to browse our hot offers',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(emailController, "Email",
                      prefIcon: const Icon(Icons.email)),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(passwordController, "Password",
                      prefIcon: const Icon(Icons.lock)),
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        child: const Text(
                          "forget your password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {}),
                  ),
                  normalButton("LOGIN", primaryColor, white, onPressed: () {
                    Get.toNamed(RouteName.dashBoard);
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            "OR Sign With",
                          )),
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.google,
                              size: 35, color: Colors.blue)),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.facebook,
                              size: 35, color: Colors.blueAccent)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(RouteName.registerScreen);
                          },
                          child: const Text("REGISTER"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
