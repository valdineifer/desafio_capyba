import 'package:desafio_capyba/controllers/auth_controller.dart';
import 'package:desafio_capyba/widgets/email_widget.dart';
import 'package:desafio_capyba/widgets/password.widget.dart';
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
          LoginForm()
        ]),
      )),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Verifique se os dados inseridos são válidos')),
      );
    }

    await _authController.loginWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        onError: (String message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        onSuccess: () async => Navigator.of(context).pushReplacementNamed('/'),
        toggleLoading: (bool value) {
          setState(() {
            isLoading = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          EmailField(controller: emailController),
          PasswordField(controller: passwordController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () => onSubmit(),
                child: const Text('Login'),
              ),
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
