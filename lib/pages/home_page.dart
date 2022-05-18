import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _navbarWidgets = <Widget>[
    const HomeWidget(),
    const AreaRestritaWidget()
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Conteúdo da Home Widget'));
  }
}

class AreaRestritaWidget extends StatelessWidget {
  const AreaRestritaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Conteúdo da Area Restrita'));
  }
}
