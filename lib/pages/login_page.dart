import 'package:desafio_capyba/widgets/email_widget.dart';
import 'package:desafio_capyba/widgets/password.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text('Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
          ),
          AuthForm()
        ]),
      )),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  AuthFormState createState() {
    return AuthFormState();
  }
}

class AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_firebaseAuth.currentUser != null) {
      Navigator.pushNamed(context, '/panel');
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const EmailField(),
          const PasswordField(),
          SizedBox(
            width: 120,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Verifique se os dados inseridos são válidos')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('ou cadastre-se', style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}
