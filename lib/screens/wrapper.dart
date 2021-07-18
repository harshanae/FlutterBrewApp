import 'package:brew_crew/models/sys_user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<Sys_user?>(context);
    print(user);
    if(user!=null){
      return Home();
    }else{
      return Authenticate();
    }

    //return either Home or Authenticate widget
    return Authenticate();
  }
}
