import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Panier extends StatefulWidget {
  const Panier({ Key? key }) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
      primary: const Color(0xFFD36135),
      fixedSize:  const Size(30, 35),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));
  
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('Panier')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        num somme = 0;
        if (!snapshot.hasData) {
          return const Center(child: Text('Loading...'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView(

                children: snapshot.data!.docs.map((panier) {
                  somme += panier['Prix'];
                  
                  return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            ListTile(
                              leading: Image.network(panier['Image']),
                              title: Text(panier['Titre']),
                              subtitle: Text('Taille ' +
                                  panier['Taille'] +', ' +
                                  panier['Prix'].toString() +' €'),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ElevatedButton(
                                  child: const Text('X'),
                                  style: style,
                                  onPressed: () {
                                    somme = somme - panier['Prix'];
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString())
                                        .collection('Panier')
                                        .doc(panier.id)
                                        .delete();
                                  },
                                )
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
            Text("Somme totale : " + somme.toString()+ " €"),
            const SizedBox(
                  height: 35.0,
                )
          ],
        );
        });

  }
}