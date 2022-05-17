import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController? controller;

  const EmailField({
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Email',
        ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Digite seu email';
          }

          if (!EmailValidator.validate(value)) {
            return 'Digite um email válido';
          }

          return null;
        },
      ),
    );
  }
}
