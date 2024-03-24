import 'package:flutter/material.dart';
import 'package:health_care_app/auth/forgot_pass_page.dart';
import 'package:health_care_app/auth/google_button.dart';
import 'package:health_care_app/auth/login_page_template.dart';
import 'package:health_care_app/auth/sign_up_page.dart';
import 'package:health_care_app/main.dart';
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
      body: Column(
        children: [
          TextInputForm(
              width: size.width * 0.9, hint: "E-mail", controller: email),
          const SizedBox(height: 5),
          TextInputForm(
            width: size.width * 0.9,
            hint: "Password",
            controller: password,
            hideText: true,
          ),
          const SizedBox(height: 5),
          GoogleButton(
              width: size.width * 0.9,
              title: "Continue with Google",
              onPressed: () {
                // TODO: Logika za logowaniem przez GOOGLE. Jeżeli się uda to Navigator
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ));
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              MyTextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage())),
                  title: "Sign up",
                  textPadding: const EdgeInsets.only(left: 3)),
            ],
          ),
          MyTextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPassPage())),
              title: "Forgot your password?",
              textPadding: EdgeInsets.zero),
          const SizedBox(height: 10),
          SimpleButton(
              title: "Login",
              textColor: Colors.black,
              onPressed: () {
                // TODO: Logika za logowaniem. Jeżeli się uda to Navigator na MyHomePage

                String userEmail = email.text;
                String userPassword = password.text;

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ));
              }),
        ],
      ),
    );
  }
}
