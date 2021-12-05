
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged/mainApp/main_page.dart';
import 'package:miaged/firstScreen/inscription.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  

  void connexion() async{
    if (_key.currentState!.validate()){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text,);
        
        setState(() {
          errorMessage = '';
        });
        Navigator.pushAndRemoveUntil( // pour éviter d'avoir un bouton "back" en haut à gauche de la page
        context,
        MaterialPageRoute(builder: (context) => const Core()), // Pour accéder à une nouvelle page 
          (Route<dynamic> route) => false,
          );
      } on FirebaseAuthException catch (error) {

        setState(() {
          errorMessage = error.message!;
        });
      }
      
    }
    
  }

  void inscription() async{

    Navigator.push( 
      context,
      MaterialPageRoute(builder: (context) => const Inscription()), 
        );
  }


  @override
  Widget build(BuildContext context){

    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
      primary: const Color(0xFFD36135),
      fixedSize:  Size(MediaQuery.of(context).size.width, 45),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)));
    
    return MaterialApp(

      theme: ThemeData(
        primaryColor: const Color(0xFF7A008A),
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

      appBar: AppBar(
        title: const Text('Miaged',style: TextStyle(fontFamily: 'thebrands', fontSize: 30)),
      ),

      body: SingleChildScrollView(
        child:
        Form(
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
                      controller : emailController,
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

                    const SizedBox(
                      height: 35.0,
                    ),

                    Text(errorMessage),

                    ElevatedButton(
                      style: style,
                      onPressed: connexion,
                      child: const Text('Se connecter'),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    ElevatedButton(
                      style: style,
                      onPressed: inscription,
                      child: const Text('S\'inscrire'),
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

    )
    ));
  }
}

String? validateEmail(String? formEmail) {
  if(formEmail == null || formEmail.isEmpty){
    return 'Champ Login manquant';
    
  }
  return null;
}

String? validatePassword(String? formPassword) {
  if(formPassword == null || formPassword.isEmpty){
    return 'Champ Password manquant';
    
  }
  RegExp checkLetter = RegExp(r".*[A-Za-z].*");

  if (!checkLetter.hasMatch(formPassword)) {
    return 'Veuillez indiquer un Password avec au moins une lettre.';
  } 
  
  return null;
}
