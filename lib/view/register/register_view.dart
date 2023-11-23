import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/components/common_widgets.dart';
import '../../../res/constants/app_color.dart';
import '../../view_model/login_register/login_view_model.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  LoginRegViewModel loginRegViewModel = Get.find();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(),
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
                    'Register',
                    style: TextStyle(fontSize: 38, color: textPrimary),
                  ),
                  Text(
                    'Register now to browse our hot offers',
                    style: TextStyle(fontSize: 18, color: textSecondary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(loginRegViewModel.nameController, "User Name",
                      prefIcon: Icon(Icons.person, color: textPrimary)),
                  const SizedBox(height: 30),
                  normalTextField(
                      loginRegViewModel.emailController.value, "Email address",
                      prefIcon: Icon(
                        Icons.email_outlined,
                        color: textPrimary,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(
                      loginRegViewModel.passwordController.value, "Password",
                      prefIcon: Icon(
                        Icons.lock_outline,
                        color: textPrimary,
                      )),
                  const SizedBox(height: 30),
                  normalTextField(loginRegViewModel.phoneController, "Phone",
                      prefIcon: Icon(
                        Icons.phone,
                        color: textPrimary,
                      )),
                  const SizedBox(height: 15),
                  normalButton("Register", primaryColor, white,
                      onPressed: () async {
                    loginRegViewModel
                        .registerWithEmailPassword()
                        .whenComplete(() {});
                  }),
                  const SizedBox(
                    height: 15,
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
