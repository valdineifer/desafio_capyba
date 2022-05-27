import 'package:desafio_capyba/services/auth_service.dart';
import 'package:desafio_capyba/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<HomePage> {
  static const _homeIndex = 0;
  int _selectedIndex = _homeIndex;

  final List<Widget> _navbarWidgets = <Widget>[
    HomeWidget(),
    const AreaRestritaWidget()
  ];

  Future<void> _onTap(int index) async {
    final user = AuthService().user;

    if (user == null) {
      return;
    }

    if (index != _homeIndex && !user.emailVerified) {
      await showDialog(
        context: context,
        builder: (context) => const EmailVerifiedDialog(),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio Capyba'),
      ),
      drawer: HomeDrawer(),
      body: _navbarWidgets.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Área Restrita',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
      ),
    );
  }
}

class EmailVerifiedDialog extends StatelessWidget {
  const EmailVerifiedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Área Restrita'),
      content: const Text(
          '''Esta é uma área apenas para usuários com e-mail verificado.
Confirme seu e-mail de cadastro.'''),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class HomeWidget extends StatelessWidget {
  final AuthService _authController = AuthService();

  HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Conteúdo da Home Widget'),
        SizedBox(
          width: 100,
          height: 40,
          child: OutlinedButton(
              onPressed: () => _authController.logout(
                    onSuccess: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
              child: const Text("Logout")),
        )
      ],
    ));
  }
}

class AreaRestritaWidget extends StatelessWidget {
  const AreaRestritaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Conteúdo da Area Restrita'));
  }
}
