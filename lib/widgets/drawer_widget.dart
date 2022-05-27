import 'package:desafio_capyba/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final user = AuthService().user;

  HomeDrawer({
    Key? key,
  }) : super(key: key);

  Widget _getAccountPicture(String photoUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        user!.photoURL!,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: user?.photoURL != null
                ? _getAccountPicture(user!.photoURL!)
                : null,
            accountName: Text(user?.displayName ?? ''),
            accountEmail: Text(user?.email ?? ''),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
          ),
          const Spacer(),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair da Conta'),
            onTap: () async {
              await AuthService().logout(onSuccess: () {
                Navigator.of(context).pushReplacementNamed('/login');
              });
            },
          )
        ],
      ),
    );
  }
}
