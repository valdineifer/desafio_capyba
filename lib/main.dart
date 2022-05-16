import 'package:desafio_capyba/pages/login_page.dart';
import 'package:desafio_capyba/pages/panel_page.dart';
import 'package:desafio_capyba/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
      title: 'Desafio Capyba',
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const LoginPage(),
        '/panel': (context) => const PanelPage(),
        '/signup': (context) => const SignUpPage()
      },
    );
  }
}
