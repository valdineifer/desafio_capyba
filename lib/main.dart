import 'package:desafio_capyba/pages/login_page.dart';
import 'package:desafio_capyba/pages/home_page.dart';
import 'package:desafio_capyba/pages/signup_page.dart';
import 'package:desafio_capyba/widgets/loading_widget.dart';
import 'package:desafio_capyba/widgets/will_pop_wrapper.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _firebaseAuth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const LoadingWidget();
            default:
              late final initialRoute = snapshot.hasData ? '/' : '/login';

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme:
                    ThemeData(useMaterial3: true, primarySwatch: Colors.green),
                title: 'Desafio Capyba',
                initialRoute: initialRoute,
                routes: {
                  '/login': (context) =>
                      const WillPopWrapper(child: LoginPage()),
                  '/': (context) => const WillPopWrapper(child: HomePage()),
                  '/signup': (context) => const SignUpPage()
                },
              );
          }
        });
  }
}
