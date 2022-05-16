import 'package:flutter/material.dart';

class PanelPage extends StatelessWidget {
  const PanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Usuário logado. Este é o painel!"),
      ),
    );
  }
}
