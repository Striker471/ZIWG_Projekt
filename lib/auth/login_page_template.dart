import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/blank_scaffold.dart';

class LoginPageTemplate extends StatelessWidget {
  final Widget body;
  final bool showLeading;
  final String title;
  final String photoUrl;
  const LoginPageTemplate(
      {super.key,
      required this.body,
      this.showLeading = true,
      this.title = 'Health Care App',
      this.photoUrl = 'assets/undraw_medicine_b-1-ol-2.svg'});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
      showLeading: showLeading,
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? size.height * 0.2
                      : 20),
              SvgPicture.asset(
                photoUrl,
                height: size.height * 0.25,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              body,
            ],
          ),
        ),
      ),
    );
  }
}
