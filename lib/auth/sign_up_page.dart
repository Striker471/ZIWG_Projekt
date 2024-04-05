// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/auth/login_page.dart';
import 'package:health_care_app/auth/login_page_template.dart';
import 'package:health_care_app/widgets/message.dart';
import 'package:health_care_app/widgets/simple_button.dart';
import 'package:health_care_app/widgets/text_input_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginPageTemplate(
      title: "Sign Up",
      photoUrl: 'assets/undraw_undraw_sign_up_ln1s_-1-_s4bc.svg',
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
          TextInputForm(
            width: size.width * 0.9,
            hint: 'Repeat password',
            controller: repeatPassword,
            hideText: true,
          ),
          const SizedBox(height: 10),
          SimpleButton(
              title: 'Sign up',
              textColor: Colors.black,
              onPressed: () async {
                String userEmail = email.text;
                String userPassword = password.text;
                String userRepeatPassword = repeatPassword.text;

                try {
                  await signUp(userEmail, userPassword, userRepeatPassword);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                } catch (e) {
                  displayErrorMotionToast('Failed to sign up.', context);
                }
              }),
        ],
      ),
    );
  }

  Future signUp(String email, String password, String repeatPassword) async {
    if (password != repeatPassword) {
      throw Exception("The passwords are not identical");
    }
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
