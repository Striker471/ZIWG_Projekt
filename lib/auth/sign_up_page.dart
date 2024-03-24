import 'package:flutter/material.dart';
import 'package:health_care_app/auth/login_page.dart';
import 'package:health_care_app/auth/login_page_template.dart';
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
          TextInputForm(
            width: size.width * 0.9,
            hint: "Repeat password",
            controller: repeatPassword,
            hideText: true,
          ),
          const SizedBox(height: 10),
          SimpleButton(
              title: "Sign up",
              textColor: Colors.black,
              onPressed: () {
                // TODO: Logika za rejestracją. Jeżeli się uda to Navigator na Login page aby się zalogować

                String userEmail = email.text;
                String userPassword = password.text;
                String userRepeatPassword = repeatPassword.text;

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
              }),
        ],
      ),
    );
  }
}
