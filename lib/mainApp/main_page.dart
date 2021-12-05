
import 'package:flutter/material.dart';
import 'package:miaged/mainApp/panier.dart';
import 'package:miaged/mainApp/profil.dart';
import 'package:miaged/mainApp/tabbar.dart';


class Core extends StatefulWidget {
  
  const Core({Key? key}) : super(key: key);

  @override
  _CoreState createState() => _CoreState();
}
class _CoreState extends State<Core> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[  
    const Tabbar(),
    const Panier(),
    const Profil()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
    });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color : Color(0xFF7A008A),
        ),     
      ),

      home:  Scaffold(

      appBar: AppBar(
        title: const Text('Miaged',style: TextStyle(fontFamily: 'thebrands', fontSize: 30)),
      ),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),   
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Acheter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:const Color(0xFF7A008A),
        onTap: _onItemTapped,
      ),
    ));
  }
}







