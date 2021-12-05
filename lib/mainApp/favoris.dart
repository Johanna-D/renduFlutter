import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged/mainApp/main_page.dart';

class Favoris extends StatefulWidget {
  const Favoris({ Key? key }) : super(key: key);

  @override
  _FavorisState createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {

  
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
      primary: const Color(0xFFD36135),
      fixedSize:  const Size(150, 35),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));
    return MaterialApp(

      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color : Color(0xFF7A008A),
        ),   
      ),

      home: Scaffold(
        appBar: AppBar(
        title: const Text('Miaged',style: TextStyle(fontFamily: 'thebrands', fontSize: 30)),
        ),
        body : Center(
          child:  StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                .collection('Favoris')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView(

                      children: snapshot.data!.docs.map((favoris) {
                                          
                        return Center(
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  ListTile(
                                    leading: Image.network(favoris['Image']),
                                    title: Text(favoris['Titre']),
                                    subtitle: Text('Taille ' +
                                        favoris['Taille'] +', ' +
                                        favoris['Prix'].toString() +' €'),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ElevatedButton(
                                        child: const Text('X'),
                                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
                                          primary: const Color(0xFFD36135),
                                          fixedSize:  const Size(30, 35),
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40))),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid
                                                  .toString())
                                              .collection('Favoris')
                                              .doc(favoris.id)
                                              .delete();
                                        },
                                      ),

                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
                                          primary: const Color(0xFFD36135),
                                          fixedSize:  const Size(200, 35),
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40))),
                                        onPressed: () {

                                          FirebaseFirestore.instance.collection('Users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid.toString()) 
                                          .collection('Panier')
                                          .doc(favoris['Id'])
                                          .set({
                                          'Titre': favoris['Titre'],
                                          'Prix' : favoris['Prix'] ,
                                          'Marque' : favoris['Marque'],
                                          'Image' : favoris['Image'],
                                          'Taille' : favoris['Taille']
                                        });
                                        showDialog(context: context, builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Confirmation'),
                                            content: const Text('L\'article a bien été ajouté à votre panier.'),
                                            actions : <Widget>[
                                              ElevatedButton(
                                                style: style,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Retour aux favoris'),
                                              )
                                            ]

                                          );
                                                          
                                        }
                                        );
                                        },
                                        child: const Text('Ajouter au panier'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                        height: 10,
                                      )
                                ],
                              ),

                            )
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
                      primary: const Color(0xFFD36135),
                      fixedSize:  const Size(250, 50),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                    onPressed:  () {
                      Navigator.pushAndRemoveUntil( 
                        context,
                        MaterialPageRoute(builder: (context) => const Core()), 
                          (Route<dynamic> route) => false,
                          );
                    },
                    child: const Text('Retour aux vêtements')),
                  const SizedBox(
                        height: 35,
                      )
                      
                    ],
              );
              }))));
  }
}