import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;

  const PasswordField({
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _isHidden,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Senha',
          suffix: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: _togglePasswordView,
            child: _isHidden
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
        ),
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Digite sua senha';
          }
          return null;
        },
      ),
    );
  }
}
