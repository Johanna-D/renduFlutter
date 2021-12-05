import 'package:flutter/material.dart';
import 'package:miaged/mainApp/vetements_tous.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({ Key? key }) : super(key: key);

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
          length: 4,
          child: Column(
            children: const <Widget>[

              Material(
                color: Color(0xFF9c68a3),
                child: TabBar(
                  indicatorColor: Color(0xFF7A008A),
                  tabs:  [
                    Tab(text:'Tous'),
                    Tab(text:'Hauts'),
                    Tab(text:'Robes'),
                    Tab(text:'Bas')
                  ],
                )
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  children: [
                    Vetements(categorie: null),
                    Vetements(categorie: 'Haut'),
                    Vetements(categorie: 'Robe'),
                    Vetements(categorie: 'Bas')
                  ],
                ),
              )
            ],
          ));
  }
}