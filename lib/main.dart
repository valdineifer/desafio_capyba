import 'package:desafio_capyba/pages/login_page.dart';
import 'package:desafio_capyba/pages/home_page.dart';
import 'package:desafio_capyba/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late User? currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    currentUser = _firebaseAuth.currentUser;
  }

  Future<User?> _checkCurrentUser() async {
    if (currentUser != null) {
      return Future.delayed(Duration.zero, () async {
        await currentUser?.reload();

        User refreshedUser = _firebaseAuth.currentUser!;
        return refreshedUser;
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _checkCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
              );
            default:
              late final initialRoute = snapshot.hasData ? '/' : '/login';

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme:
                    ThemeData(useMaterial3: true, primarySwatch: Colors.green),
                title: 'Desafio Capyba',
                initialRoute: initialRoute,
                routes: {
                  '/login': (context) => const LoginPage(),
                  '/': (context) => const HomePage(),
                  '/signup': (context) => const SignUpPage()
                },
              );
          }
        });
  }
}
