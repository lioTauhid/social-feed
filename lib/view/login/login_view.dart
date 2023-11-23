import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_feed/res/constants/app_color.dart';
import '../../../res/components/common_widgets.dart';
import '../../../res/routes/routes_name.dart';
import '../../view_model/login_register/login_view_model.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginRegViewModel loginRegViewModel = Get.put(LoginRegViewModel());

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 38, color: textPrimary),
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: TextStyle(fontSize: 18, color: textSecondary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(
                      loginRegViewModel.emailController.value, "Email",
                      prefIcon: Icon(Icons.email, color: textPrimary)),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(
                      loginRegViewModel.passwordController.value, "Password",
                      prefIcon: Icon(
                        Icons.lock,
                        color: textPrimary,
                      )),
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        child: Text(
                          "forget your password",
                          style: TextStyle(color: textSecondary),
                        ),
                        onPressed: () {}),
                  ),
                  normalButton("LOGIN", primaryColor, white, onPressed: () {
                    loginRegViewModel
                        .loginWithEmailPassword()
                        .whenComplete(() {});
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
                          child: Text(
                            "OR Sign With",
                            style: TextStyle(color: textSecondary),
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
                          onPressed: () {
                            loginRegViewModel.signInWithGoogle();
                          },
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
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: textSecondary),
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
