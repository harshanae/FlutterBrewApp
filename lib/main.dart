import 'package:brew_crew/models/sys_user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Sys_user?>.value(
      value: AuthService().authStateChanges,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}



class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<Sys_user?>();

    if(firebaseUser!=null){
      return Home();
    }else{
      return SignIn();
    }

  }
}


