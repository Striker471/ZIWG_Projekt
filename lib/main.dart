// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/auth/login_page.dart';
import 'package:health_care_app/firebase_options.dart';
import 'package:health_care_app/global.dart';
import 'package:health_care_app/widgets/action_container.dart';
import 'package:health_care_app/widgets/message.dart';
import 'package:health_care_app/widgets/search_bar_container.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  await initializeDateFormatting();
  FlutterNativeSplash.remove();
  tz.initializeTimeZones();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Care App',
      theme: ThemeData(
        dialogTheme: const DialogTheme(elevation: 0),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        colorScheme: const ColorScheme.light(primary: Color(0xFF6EDF79)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const LoginPage(),
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredActions = [];

  @override
  void initState() {
    super.initState();
    filteredActions = homePageActions;
    searchController.addListener(() {
      filterActions();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterActions() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredActions = homePageActions;
      });
    } else {
      setState(() {
        filteredActions = homePageActions
            .where((action) => action.keys.first.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/Shape.svg',
            height: size.height * 0.2,
          ),
          SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height * 0.2),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user == null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            } else {
                              displayErrorMotionToast(
                                  'Failed to log out.', context);
                            }
                          } catch (e) {
                            displayErrorMotionToast(
                                'Failed to log out.', context);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome in Health Care App',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'What are you looking for?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SearchBarContainer(search: searchController),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    childAspectRatio: 1.1,
                    physics: const NeverScrollableScrollPhysics(),
                    children: filteredActions.map((action) {
                      String title = action.keys.first;
                      return Center(
                        child: ActionContainer(
                          title: title,
                          assetUrl: action[title]!,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => getActionRoute(title)));
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
