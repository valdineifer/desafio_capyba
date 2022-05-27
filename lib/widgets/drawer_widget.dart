import 'package:desafio_capyba/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final user = AuthController().user;

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: user?.photoURL != null
                ? _getAccountPicture(user!.photoURL!)
                : null,
            currentAccountPictureSize: const Size.square(80),
            accountName: Text(user?.displayName ?? ''),
            accountEmail: Text(user?.email ?? ''),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
