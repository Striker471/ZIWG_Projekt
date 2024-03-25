import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/global.dart';

class BlankScaffold extends StatelessWidget {
  final Widget body;
  final bool showLeading;
  const BlankScaffold({super.key, required this.body, this.showLeading = true});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      SvgPicture.asset(
        'assets/Shape.svg',
        height: size.height * 0.2,
      ),
      body,
      if (showLeading)
        Positioned(
          top: 15,
          left: 15,
          child: IconButton(
            icon: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: boxShadow,
                ),
                child: Icon(Icons.arrow_back,
                    size: 35, color: Theme.of(context).primaryColor)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
    ]));
  }
}
