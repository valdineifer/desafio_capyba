import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController? controller;

  const NameField({
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Nome',
        ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Digite seu nome';
          }

          if (value.length < 3) {
            return 'O nome deve ter no mínimo 3 caracteres';
          }

          return null;
        },
      ),
    );
  }
}
