import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_dart.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Home extends StatelessWidget {
  // final AuthService _auth = AuthService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: <Brew>[],
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            title: Text("Brew Crew"),
            actions: [
              IconButton(onPressed:()async{await AuthService().signOut();}, icon: Icon(Icons.logout)),
              FlatButton.icon(onPressed: ()=>_showSettingsPanel(), icon: Icon(Icons.settings), label: Text("Settings"))
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover
              )
            ),
              child: BrewList()
          ),
        ),
      ),
    );
  }
}


