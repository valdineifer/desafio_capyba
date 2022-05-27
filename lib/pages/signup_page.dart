import 'dart:io';

import 'package:desafio_capyba/services/auth_service.dart';
import 'package:desafio_capyba/widgets/email_widget.dart';
import 'package:desafio_capyba/widgets/name_field_widget.dart';
import 'package:desafio_capyba/widgets/password.widget.dart';
import 'package:desafio_capyba/widgets/selfie_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
      ),
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
  final AuthService _authService = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imageFile;

  bool _isLoading = false;
  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
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

    isLoading = true;

    if (!_formKey.currentState!.validate()) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text('Verifique se os dados inseridos são válidos')),
      );
      isLoading = false;
      return;
    }

    if (imageFile == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content:
                Text('Selfie obrigatória! Clique no ícone para tirar uma.')),
      );
      isLoading = false;
      return;
    }

    await _authService.signUpWithEmailAndPassword(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        imageFile: imageFile!,
        onError: (String message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          isLoading = false;
        });

    isLoading = false;
    navigator.pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SelfieField(onTakePicture: setImageFile),
          NameField(controller: nameController),
          EmailField(controller: emailController),
          PasswordField(controller: passwordController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () => onSubmit(),
                child: !_isLoading
                    ? const Text('Cadastre-se')
                    : const CircularProgressIndicator(
                        backgroundColor: Colors.lightGreenAccent,
                      ),
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
