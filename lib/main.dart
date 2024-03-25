import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/auth/login_page.dart';
import 'package:health_care_app/global.dart';
import 'package:health_care_app/widgets/action_container.dart';
import 'package:health_care_app/widgets/search_bar_container.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
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
                  SizedBox(height: size.height * 0.2),
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
                    child: SearchBarContainer(
                        onSubmitted: (searchString) {
                          //FIXME: nwm po co to więc potem się będziemy zastanawiać co z tym zrobić
                        },
                        search: search),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    childAspectRatio: 1.15,
                    physics: const NeverScrollableScrollPhysics(),
                    children: homePageActions.map((action) {
                      String title = action.keys.first;
                      return Center(
                        child: ActionContainer(
                            title: title,
                            assetUrl: action[title]!,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => getActionRoute(title)));
                            }),
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
