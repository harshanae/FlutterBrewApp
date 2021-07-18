import 'package:brew_crew/models/sys_user.dart';
import 'package:brew_crew/screens/authenticate/loading.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentNAme;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Sys_user?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userdata,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData? userData=snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Update your brew settings", style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (val)=> val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val){
                    setState(() {
                      _currentNAme=val;
                    });
                  },
                ),
                SizedBox(height: 20,),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text('$sugar sugars'),
                      value: sugar,
                    );
                  }).toList(),
                  onChanged: (val){
                    setState(() {
                      _currentSugars=val as String?;
                    });
                  },
                ),
                //slider
                Slider(
                    min: 100,
                    max: 900,
                    activeColor: Colors.brown[_currentStrength ?? userData.strength!],
                    inactiveColor: Colors.brown,
                    divisions: 8,
                    value: (_currentStrength ?? 100).toDouble(),
                    onChanged: (val){
                      setState(() {
                        _currentStrength=val.round();
                      });
                    }
                ),
                RaisedButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars!,
                          _currentNAme ?? userData.name!,
                          _currentStrength ?? userData.strength!
                      );
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),

                )

              ],
            ),
          );
        }else{
          return Loading(

          );
        }
      }
    );
  }
}
