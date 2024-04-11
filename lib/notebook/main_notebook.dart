import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/notebook/insert_pdf_page.dart';

class MainNotebook extends StatefulWidget {
  const MainNotebook({super.key});

  @override
  State<MainNotebook> createState() => _MainNotebookState();
}

class _MainNotebookState extends State<MainNotebook> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
        floatingActionButton: SpeedDial(
          overlayColor: Colors.black,
          activeIcon: Icons.close,
          icon: Icons.add,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
              shape: const CircleBorder(),
              child: const Icon(Icons.plus_one),
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              onTap: () {
                //TODO: form
              },
            ),
            SpeedDialChild(
              shape: const CircleBorder(),
              child: const Icon(Icons.picture_as_pdf),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              visible: true,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InsertPdfPage())),
            ),
          ],
        ),
        body: SizedBox(
            width: size.width,
            child: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70),
                  //TODO: body
                ],
              ),
            )));
  }
}
