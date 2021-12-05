import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String id;
  final String titre;
  final String image;
  final String marque;
  final String taille;
  final int prix;

  const Details({Key? key,required this.id, required this.titre, required this.image, required this.marque, required this.taille, required this.prix}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {

  bool isPressed = false;

    @override
  Widget build(BuildContext context) {
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
      primary: const Color(0xFFD36135),
      fixedSize:  const Size(170, 35),
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

      body: Center(

        child: Card(

          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  widget.image,
                  height: 300,
                  fit:BoxFit.fitHeight // Pour voir l'image en grand 
                ),
              ),

              ListTile(
                title:  Text(widget.titre),
                subtitle: Text('Vêtement de la marque '+ widget.marque +', taille '+ widget.taille +'. \nEn vente à ' + widget.prix.toString() + ' €.' ),
              ),
              const SizedBox(
                    height: 10,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      FirebaseFirestore.instance.collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid.toString()) 
                      .collection('Favoris')
                      .doc(widget.id)
                      .set({
                      'Id' : widget.id,
                      'Titre': widget.titre,
                      'Prix' : widget.prix ,
                      'Marque' : widget.marque,
                      'Image' : widget.image,
                      'Taille' : widget.taille
                    });
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('L\'article a bien été ajouté à vos favoris.'),
                        actions : <Widget>[
                          ElevatedButton(
                            style: style,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Retour à l\'article'),
                          ),
                        ]);
                      });},
                    child:  const Text('Favoris')),
                  

                  const SizedBox(
                    width: 20,
                  ),

                  ElevatedButton(
                    style: style,
                    onPressed: () {

                      FirebaseFirestore.instance.collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid.toString()) 
                      .collection('Panier')
                      .doc(widget.id)
                      .set({
                      'Titre': widget.titre,
                      'Prix' : widget.prix ,
                      'Marque' : widget.marque,
                      'Image' : widget.image,
                      'Taille' : widget.taille
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
                            child: const Text('Retour à l\'article'),
                          )
                        ]

                      );
                                      
                    }
                    );
                    },
                    child: const Text('Ajouter au panier'),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  

                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(
                    height: 30,
                  ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
                      primary: const Color(0xFFD36135),
                      fixedSize:  const Size(150, 35),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                    onPressed: () {
                      Navigator.pop(context);
                      },
                    child: const Text('Retour'),
                  )),
              
              const SizedBox(
                    height: 10,
                  ),
            ],
          ),
        )    
      ),
      )
    );
  }
 }

