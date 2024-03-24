import 'package:flutter/material.dart';
import 'package:health_care_app/auth/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Care APP',
      theme: ThemeData(
        dialogTheme: const DialogTheme(elevation: 0),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        colorScheme: const ColorScheme.light(primary: Color(0xFF6EDF79)),
        useMaterial3: true,
        fontFamily: "Poppins",
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
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("To be HomePage"),
      ),
    );
  }
}
