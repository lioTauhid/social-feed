import 'package:flutter/material.dart';

import '../../../res/components/common_widgets.dart';
import '../../../res/constants/app_color.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 38,
                    ),
                  ),
                  const Text(
                    'Register now to browse our hot offers',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(emailController, "User Name",
                      prefIcon: const Icon(Icons.person)),
                  const SizedBox(
                      height: 30
                  ),
                  normalTextField(emailController, "Email address",
                      prefIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(emailController, "Password",
                      prefIcon: const Icon(Icons.lock_outline)),
                  const SizedBox(
                      height: 30
                  ),
                  normalTextField(emailController, "Phone",
                      prefIcon: const Icon(Icons.phone)),
                  const SizedBox(
                      height: 15
                  ),
                  normalButton(
                      "Register", primaryColor, white, onPressed: () {}),
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