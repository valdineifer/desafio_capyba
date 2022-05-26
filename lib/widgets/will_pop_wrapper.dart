import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WillPopWrapper extends StatefulWidget {
  final Widget child;

  const WillPopWrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WillPopWrapperState();
}

class WillPopWrapperState extends State<WillPopWrapper> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmação'),
            content: const Text('Você quer sair do aplicativo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: widget.child);
  }
}
