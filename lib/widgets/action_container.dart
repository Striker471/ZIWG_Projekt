import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionContainer extends StatelessWidget {
  final String title;
  final String assetUrl;
  const ActionContainer(
      {super.key, required this.title, required this.assetUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        //FIXME: naprawić po stworzeniu stron
      },
      child: Container(
          width: size.width * 0.45,
          decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SvgPicture.asset(
                assetUrl,
                height: 120,
              ),
            ],
          )),
    );
  }
}
