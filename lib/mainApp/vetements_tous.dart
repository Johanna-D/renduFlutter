import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class Vetements extends StatefulWidget {
  final String? categorie;
  const Vetements({ Key? key , required this.categorie}) : super(key: key);

  @override
  _VetementsState createState() => _VetementsState();
}

class _VetementsState extends State<Vetements> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15), 
      primary: const Color(0xFFD36135),
      fixedSize:  const Size(150, 35),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));
    

    return StreamBuilder(

      stream: FirebaseFirestore.instance
        .collection('Vêtements')
        .where('Categorie', isEqualTo: widget.categorie)
        .snapshots(),

      builder : (context, AsyncSnapshot<QuerySnapshot> snapshot){
          
        if (!snapshot.hasData) {
          return const Center(child : Text('Loading...'));
        }
        return ListView(children : 
        
        snapshot.data!.docs.map((vetement ) {
          
          return Center(
            
            child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        ListTile(
                          leading: Image.network(vetement['Image']),
                          title: Text(vetement['Titre']),
                          subtitle: Text(vetement['Taille'] + ', ' + vetement['Prix'].toString() + ' €'  ),
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[

                            ElevatedButton(
                              child: const Text('Détails'),
                              style : style,
                              onPressed:  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Details(id: vetement.id,titre:vetement['Titre'],image:vetement['Image'],marque: vetement['Marque'],taille:vetement['Taille'],prix:vetement['Prix'])),
                                );
                              },
                            ),

                            const SizedBox(width: 8),
                          ],
                        ),

                        const SizedBox(
                              height: 10,
                            )
                      ],
                    ),
                  )
          );
        } ).toList()
        );
      }
      
      );
  }
}