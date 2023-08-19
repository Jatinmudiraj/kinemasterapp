import 'package:flutter/material.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:kindmaster/screens/Create.dart';
import 'package:kindmaster/screens/Me.dart';
import 'package:kindmaster/screens/MixScreen.dart';
import 'package:kindmaster/screens/Search.dart';

class MainPage extends StatefulWidget {
  const MainPage({key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedindex = 2;

  static const List<Widget> _screens = <Widget>[
    MixScreen(),
    Search(),
    Create(),
    Me(),


  ];

  void _onItemTapped(int index){
            setState(() {
              _selectedindex = index;
            });
          }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(250, 20, 21, 24),
          leading: Image(image: AssetImage('assets/img.png')),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.tv_sharp),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.help),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
          
          
          ),
      body: _screens.elementAt(_selectedindex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bgcolor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            color: Colors.white,
          ),
          unselectedLabelStyle: const TextStyle(color: Colors.grey,),showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: bgcolor,
                icon: Icon(Icons.diamond_sharp),
                label: 'Mix'),
            BottomNavigationBarItem(
                backgroundColor: bgcolor,
                icon: Icon(Icons.search),
                label: 'Search'),
            BottomNavigationBarItem(
                backgroundColor: bgcolor,
                icon: Icon(Icons.add_circle),
                label: 'Create'),
            BottomNavigationBarItem(
                backgroundColor: bgcolor,
                icon: Icon(Icons.person),
                label: 'Me'),
          ],
          currentIndex: _selectedindex,
          onTap: _onItemTapped,
          ),
    );
  }
}
