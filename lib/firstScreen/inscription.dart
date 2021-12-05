import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/firstScreen/connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  TextStyle textStyle = const TextStyle( fontSize: 20.0);
  final loginController = TextEditingController();
  final passwordController = TextEditingController();  
  final anniversaireController = TextEditingController();
  final adresseController = TextEditingController();
  final codepostalController = TextEditingController();
  final villeController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';


  void inscription() async{

      if (_key.currentState!.validate()){
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: loginController.text, password: passwordController.text);
          FirebaseFirestore.instance.collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString()) 
            .collection('Profil')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set({
            'Login': loginController.text,
            'Password' : passwordController.text ,
            'Anniversaire' : anniversaireController.text,
            'Adresse' : adresseController.text,
            'Code postal' : codepostalController.text,
            'Ville' : villeController.text
          });
        } on FirebaseAuthException catch (error) {
          errorMessage = error.message!;
        }

        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Inscription confirmée'),
            content: const Text('Votre inscription a bien été prise en compte.'),
            actions : <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
                                                primary: const Color(0xFFD36135),
                                                fixedSize:  const Size(300, 35),
                                                shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Retour à la page de connexion'),
              ),
            ]

          );
          
        });
    }
  }
  
  @override
  Widget build(BuildContext context){

    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
      primary: const Color(0xFFD36135),
      fixedSize:  const Size(250, 35),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));

    return MaterialApp(

      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color : Color(0xFF7A008A),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7A008A))
          ),
        )
        
      ),

      home: Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Miaged',style: TextStyle(fontFamily: 'thebrands', fontSize: 30)),

      ),
      body: SingleChildScrollView(
        child:Form(
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
        
                    const SizedBox(height: 45.0),

                    TextFormField(
                      controller : loginController,
                      validator: validateEmail,
                      obscureText: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Login"
                      )
                    ),

                    const SizedBox(height: 25.0),

                    TextFormField(
                      controller : passwordController,
                      validator: validatePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password"
                      )
                    ),

                    const SizedBox(height: 25.0),

                    TextFormField(
                      controller : anniversaireController,
                      validator: validateAnniversaire,
                      obscureText: false,
                      decoration:const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'ex : 01/01/2000',
                        labelText: 'Anniversaire'
                      )
                    ),

                    const SizedBox(height: 25.0),

                    TextFormField(
                      controller : adresseController,
                      validator: validateAdresse,
                      obscureText: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'ex : 1 chemin de la route',
                        labelText: 'Adresse'
                      )
                    ),

                    const SizedBox(height: 25.0),

                    TextFormField(
                      controller : codepostalController,
                      validator: validateCodePostal,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'ex : 06000',
                        labelText: 'Code postal'
                      )
                    ),

                    const SizedBox(height: 25.0),

                    TextFormField(
                      controller : villeController,
                      validator: validateVille,
                      obscureText: false,
                      decoration:const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'ex : Nice',
                        labelText: 'Ville'
                      )
                      ),

                      const SizedBox(
                        height: 35.0,
                      ),

                      Text(errorMessage),
                      
                      const SizedBox(
                        height: 35.0,
                      ),

                      ElevatedButton(
                        style: style,
                        onPressed: inscription,
                        child: const Text('Valider l\'inscription'),
                      ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    ElevatedButton(
                        style: style,
                        onPressed:() {
                          Navigator.pop(context);
                        },
                        child: const Text('Retour'),
                      ),
                      
                    const SizedBox(
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),

    )
    ));
  }
}



String? validateAnniversaire(String? formAnniversaire) {
  if(formAnniversaire == null || formAnniversaire.isEmpty){
    return 'Champ Anniversaire manquant';
    
  }
  return null;
}

String? validateAdresse(String? formAdresse) {
  if(formAdresse == null || formAdresse.isEmpty){
    return 'Champ Adresse manquant';
    
  }
  return null;
}

String? validateCodePostal(String? formCodePostal) {
  if(formCodePostal == null || formCodePostal.isEmpty){
    return 'Champ Code Postal manquant';
    
  }
  return null;
}

String? validateVille(String? formVille) {
  if(formVille == null || formVille.isEmpty){
    return 'Champ Ville manquant';
    
  }
  return null;
}
