import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/mainApp/favoris.dart';
import 'package:miaged/firstScreen/connexion.dart';

class Profil extends StatefulWidget {
  const Profil({ Key? key }) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String validationMessage = '';
  @override
  Widget build(BuildContext context) {

    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
      primary: const Color(0xFFD36135),
      fixedSize:  Size(MediaQuery.of(context).size.width, 45),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));

    return  Scaffold(

        body : Center(

          child:  StreamBuilder(

          stream: FirebaseFirestore.instance.collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('Profil')
            .snapshots(),

          builder : (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return const Center(child : Text('Loading...'));
            }
              final _key = GlobalKey<FormState>();
              final loginController = TextEditingController();
              final passwordController = TextEditingController();  
              final anniversaireController = TextEditingController();
              final adresseController = TextEditingController();
              final codepostalController = TextEditingController();
              final villeController = TextEditingController();

            return ListView(children : snapshot.data!.docs.map((profil ) {

              loginController.text = profil['Login'];
              passwordController.text = profil['Password'];
              anniversaireController.text = profil['Anniversaire'];
              adresseController.text = profil['Adresse'];
              codepostalController.text = profil['Code postal'];
              villeController.text = profil['Ville'];

              return Center(
                 
                child: Form(
                  key : _key,

                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            ElevatedButton(
                              style: style,
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Favoris()),
                                );                                
                              }, 
                              child: const Text('Mes favoris')),
                
                            const SizedBox(height: 45.0),

                            TextFormField(
                              controller : loginController,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Login'],
                                labelText: 'Login'
                              )
                            ),

                            const SizedBox(height: 25.0),

                            TextFormField(
                              controller : passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Password'],
                                labelText: 'Password'
                              )
                            ),

                            const SizedBox(height: 25.0),

                            TextFormField(
                              controller : anniversaireController,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Anniversaire'],
                                labelText: 'Anniversaire'
                              )
                            ),

                            const SizedBox(height: 25.0),

                            TextFormField(
                              controller : adresseController,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Adresse'],
                                labelText: 'Adresse'
                              )
                            ),

                            const SizedBox(height: 25.0),

                            TextFormField(
                              controller : codepostalController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Code postal'].toString(),
                                labelText: 'Code postal'
                              ),
                              
                            ),
                            const SizedBox(height: 25.0),

                            TextFormField(
                              controller : villeController,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF7A008A)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF7A008A))),
                                hintText: profil['Ville'],
                                labelText: 'Ville'
                              )
                            ),

                            const SizedBox(
                              height: 35.0,
                            ),


                            Text(validationMessage),
                            
                            ElevatedButton(
                              style: style,
                              onPressed: (){
                                FirebaseAuth.instance.currentUser!.updatePassword(passwordController.text);
                                FirebaseFirestore.instance.collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                    .collection('Profil')
                                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                    .update({
                                    'Password': passwordController.text,
                                    'Anniversaire' : anniversaireController.text ,
                                    'Adresse' : adresseController.text,
                                    'Code postal' : codepostalController.text,
                                    'Ville' :villeController.text
                                    });
                                    setState(() {
                                      validationMessage = 'Modifications validées';
                                    });

                              },
                              child: const Text("Valider",textAlign: TextAlign.center)
                              
                            ),

                            const SizedBox(
                              height: 15.0,
                            ),

                            ElevatedButton(
                              style: style,
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                );
                              },
                              child: const Text("Se déconnecter",textAlign: TextAlign.center),
                            
                            ),

                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
              );
            
            } ).toList(),
            );
            

           
          }
          
          )));
  }
}