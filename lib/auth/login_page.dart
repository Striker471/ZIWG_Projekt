// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_care_app/auth/forgot_pass_page.dart';
import 'package:health_care_app/auth/google_button.dart';
import 'package:health_care_app/auth/login_page_template.dart';
import 'package:health_care_app/auth/sign_up_page.dart';
import 'package:health_care_app/main.dart';
import 'package:health_care_app/widgets/message.dart';
import 'package:health_care_app/widgets/simple_button.dart';
import 'package:health_care_app/widgets/text_button.dart';
import 'package:health_care_app/widgets/text_input_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginPageTemplate(
      showLeading: false,
      body: Column(
        children: [
          TextInputForm(
              width: size.width * 0.9, hint: 'E-mail', controller: email),
          const SizedBox(height: 5),
          TextInputForm(
            width: size.width * 0.9,
            hint: 'Password',
            controller: password,
            hideText: true,
          ),
          const SizedBox(height: 5),
          GoogleButton(
              width: size.width * 0.9,
              title: 'Continue with Google',
              onPressed: () async {
                User? user = await signInWithGoogle();
                if (user != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyHomePage()));
                } else {
                  displayErrorMotionToast('Failed to log in.', context);
                }
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              MyTextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage())),
                  title: 'Sign up',
                  textPadding: const EdgeInsets.only(left: 3)),
            ],
          ),
          MyTextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPassPage())),
              title: 'Forgot your password?',
              textPadding: EdgeInsets.zero),
          const SizedBox(height: 10),
          SimpleButton(
              title: 'Login',
              textColor: Colors.black,
              onPressed: () async {
                String userEmail = email.text;
                String userPassword = password.text;

                try {
                  await signIn(userEmail, userPassword);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ));
                } catch (e) {
                  displayErrorMotionToast('Failed to log in.', context);
                }
              }),
        ],
      ),
    );
  }

  Future signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }
}
