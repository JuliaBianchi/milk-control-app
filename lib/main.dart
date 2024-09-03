import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milkcontrolapp/pages/home_page.dart';
import 'package:milkcontrolapp/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff001F3D)),
          useMaterial3: true),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home-page': (context) => const HomePage(),
      },
    );
  }
}
