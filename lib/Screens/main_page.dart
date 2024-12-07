import 'package:cementery/Screens/product_list_page.dart';
import 'package:cementery/dbHelper/user_crud.dart';

import 'login_page.dart';
import 'package:flutter/material.dart';
import 'MapScreen.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key, required this.title, this.user});
  String title;
  UserResp? user;

  void setTitle(String title) {
    this.title = title;
  }

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MapScreen(),
    Text(
      'Index 1: Visites',
      style: optionStyle,
    ),
    Text(
      'Index 2: Clients',
      style: optionStyle,
    ),
    ProductListPage(),
    Text(
      'Index 4: Statistique',
      style: optionStyle,
    ),
    Text(
      'Index 5: Planification',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user?.username ?? 'Guest'),
              accountEmail: Text(widget.user?.email ?? 'guest@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user.png',
                    fit: BoxFit.contain,
                    width: 90,
                    height: 70,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: const Text('Carte'),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      widget.title = 'Carte';
                      _onItemTapped(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.directions_walk),
                    title: const Text('Visites'),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      widget.title = 'Visites';
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Clients'),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      widget.title = 'Clients';
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Produits'),
                    selected: _selectedIndex == 3,
                    onTap: () {
                      widget.title = 'Produits';
                      _onItemTapped(3);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('Statistique'),
                    selected: _selectedIndex == 4,
                    onTap: () {
                      widget.title = 'Statistique';
                      _onItemTapped(4);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Planification'),
                    selected: _selectedIndex == 5,
                    onTap: () {
                      widget.title = 'Planification';
                      _onItemTapped(5);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Disconnect'),
              onTap: () {
                // Handle logout logic here
                Navigator.pop(context);
                // Go back to login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
