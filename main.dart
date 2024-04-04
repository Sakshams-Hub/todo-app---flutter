import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pract_app/form.dart';
import 'package:pract_app/grid.dart';
import 'package:pract_app/home.dart';
import 'package:pract_app/login.dart';
import 'package:pract_app/pass_data.dart';
import 'package:pract_app/signin.dart';
import 'package:pract_app/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pract_app/users.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/Grid',
      routes: {
        '/One': (context) => const StartPage(),
        '/Second': (context) => Mylogin(),
        '/Third': (context) => const MySignin(),
        '/Fourth': (context) => const MyHome(),
        '/Grid': (context) => const MyGrid(),
        '/Pass': (context) => const MyPass(),
        '/Form': (context) => const MyForm(),
        '/user': (context) => const MyUser(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.acmeTextTheme(Theme.of(context).textTheme),
        primaryColor: const Color.fromARGB(255, 226, 146, 76),
        primaryColorLight: Color.fromARGB(255, 255, 177, 108),
      ),
      // home: const MyHome(),
    );
  }
}
