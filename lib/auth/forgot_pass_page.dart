import 'package:flutter/material.dart';
import 'package:health_care_app/auth/login_page.dart';
import 'package:health_care_app/auth/login_page_template.dart';
import 'package:health_care_app/widgets/simple_button.dart';
import 'package:health_care_app/widgets/text_input_form.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginPageTemplate(
      body: Column(
        children: [
          TextInputForm(
              width: size.width * 0.9, hint: 'E-mail', controller: email),
          const SizedBox(height: 10),
          SimpleButton(
              title: 'Submit',
              textColor: Colors.black,
              onPressed: () {
                // TODO: Logika za zmianą hasła. Jeżeli się uda to Navigator na Login page aby się zalogować

                String userEmail = email.text;

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
              }),
        ],
      ),
    );
  }
}
