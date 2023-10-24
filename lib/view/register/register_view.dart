import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../res/components/common_widgets.dart';
import '../../../res/constants/app_color.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

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
                  normalTextField(nameController, "User Name",
                      prefIcon: const Icon(Icons.person)),
                  const SizedBox(height: 30),
                  normalTextField(emailController, "Email address",
                      prefIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(
                    height: 30,
                  ),
                  normalTextField(passwordController, "Password",
                      prefIcon: const Icon(Icons.lock_outline)),
                  const SizedBox(height: 30),
                  normalTextField(phoneController, "Phone",
                      prefIcon: const Icon(Icons.phone)),
                  const SizedBox(height: 15),
                  normalButton("Register", primaryColor, white,
                      onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (credential.user != null) {
                        Get.toNamed(RouteName.dashBoard);
                      }
                    } on FirebaseAuthException catch (e) {
                      Utils.showSnackBar(e.message.toString() + e.code);
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
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
