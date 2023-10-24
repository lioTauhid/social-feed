import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_feed/res/constants/app_color.dart';
import 'package:social_feed/utils/utils.dart';
import '../../../res/components/common_widgets.dart';
import '../../../res/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  normalButton("LOGIN", primaryColor, white,
                      onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      if (credential.user != null) {
                        Get.offNamed(RouteName.dashBoard);
                      }
                    } on FirebaseAuthException catch (e) {
                      Utils.showSnackBar(e.message.toString() + e.code);
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
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
                          onPressed: () {
                            signInWithGoogle();
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final User? user = (await auth.signInWithCredential(credential)).user;
    print(user);
    if (user != null) {
      Get.offNamed(RouteName.dashBoard);

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => const DashBoard()));
    }
  }
}
