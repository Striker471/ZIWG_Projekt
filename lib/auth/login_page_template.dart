import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPageTemplate extends StatelessWidget {
  final Widget body;
  const LoginPageTemplate({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // if (MediaQuery.of(context).viewInsets.bottom == 0)
          SvgPicture.asset(
            'assets/Shape.svg',
            height: size.height * 0.2,
          ),
          SizedBox(
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
                    'assets/undraw_medicine_b-1-ol-2.svg',
                    height: size.height * 0.25,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Health Care App",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  body,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
