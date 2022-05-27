import 'dart:io';

import 'package:desafio_capyba/services/auth_service.dart';
import 'package:desafio_capyba/widgets/email_widget.dart';
import 'package:desafio_capyba/widgets/password.widget.dart';
import 'package:desafio_capyba/widgets/selfie_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text('Cadastro',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
          ),
          SignUpForm()
        ]),
      )),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authController = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imageFile;

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

  void setImageFile(File file) {
    setState(() {
      imageFile = file;
    });
  }

  Future<void> onSubmit() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (!_formKey.currentState!.validate()) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text('Verifique se os dados inseridos são válidos')),
      );
      return;
    }

    if (imageFile == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content:
                Text('Selfie obrigatória! Clique no ícone para tirar uma.')),
      );
      return;
    }

    await _authController.signUpWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        imageFile: imageFile!,
        onError: (String message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        });

    navigator.pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SelfieField(onTakePicture: setImageFile),
          EmailField(controller: emailController),
          PasswordField(controller: passwordController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () => onSubmit(),
                child: const Text('Cadastre-se'),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('ou faça login', style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}
