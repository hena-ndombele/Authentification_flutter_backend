import 'package:flutter/material.dart';
import 'package:flutter_fidele/controllers/FideleCtrl.dart';
import 'package:flutter_fidele/widget/Chargement.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fidele/widget/ChampSaisie.dart';

import 'FidelesPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color couleurFond = Colors.white;

  String errorMsg = "";
  bool isVisible=false;
  var formkey=GlobalKey<FormState>();

  //capture les zones de saisie
  var username=TextEditingController();
  var password=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurFond,
      body: Stack(children: [_body(),
        Chargement(isVisible)]),
    );

  }


  Widget _body() {
    return Form(
      key: formkey,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _iconApp(),
                SizedBox(
                  height: 20,
                ),
                Text("Authentification", style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                champSaisie(ctrl:username,isPassword: false,
                label:"username",required:true),
                SizedBox(
                  height: 20,
                ),

                //affichage dans le dossier widget
                champSaisie(ctrl:password,
                    label:"Mot de passe",required:true),
                SizedBox(
                  height: 20,
                ),
                _textError(),
                _buttonWidget(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconApp() {
    return Icon(
      Icons.home,
      size: 50,
      color: Colors.orange,
    );
  }



  Widget _buttonWidget() {
    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: () async{
//faire disparaitre le clavier
          FocusScope.of(context).requestFocus(new FocusNode());
          //faire disparaitre le clavier

          //appeler tout les validator de chaque fin de saisie
          if (!formkey.currentState!.validate()){
            return;

          }

        //capture les zones de saisie
          print(username.text);
          print(password.text);


          errorMsg = "Mot de passe incorrect";
          isVisible=true;
          setState(() {});
          //traitement
          //appeler le controller
          var Ctrl=context.read<FideleCtrl>();
          Map donneesAEnvoyer={"username": username.text};

      bool status =    await Ctrl.envoieDonneesAuth(donneesAEnvoyer);
          await Future.delayed(Duration(seconds: 2));

          isVisible=false;
          setState(() {});
          if(status){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder:(context) => FidelesPage()),
            );
          }
        },
        child: Text("Connexion"),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

  OutlineInputBorder _bordure(MaterialColor _color) {
    return OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: _color),
        borderRadius: BorderRadius.all(Radius.circular(16)));
  }

  Widget _textError() {
    return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
  }
}
