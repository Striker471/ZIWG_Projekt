import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/localization/hospital_finder.dart';
import 'package:health_care_app/localization/pharmacy_finder.dart';

List<Map<String, String>> homePageActions = [
  {'Pill notifications': 'assets/undraw_medical_care_movn.svg'},
  {'Med notebook': 'assets/undraw_undraw_notebook_ask4_ew5s.svg'},
  {'...': 'assets/undraw_doctors_p6aq.svg'},
  {'Chat bot': 'assets/undraw_chat_re_re1u.svg'},
  {'Nearest hospitals': 'assets/undraw_building_re_xfcm.svg'},
  {'Nearest pharmacies': 'assets/undraw_map_re_60yf.svg'},
];

Widget getActionRoute(String actionKey) {
  switch (actionKey) {
    case 'Pill notifications':
      return const BlankScaffold(body: SizedBox());
    case 'Med notebook':
      return const BlankScaffold(body: SizedBox());
    case '...':
      return const BlankScaffold(body: SizedBox());
    case 'Chat bot':
      return const BlankScaffold(body: SizedBox());
    case 'Nearest hospitals':
      return const HospitalFinder();
    case 'Nearest pharmacies':
      return const PharmacyFinder();
  }
  return const SizedBox.shrink();
}

List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: Colors.grey,
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: Offset(0.0, 4.0),
  )
];

copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}
