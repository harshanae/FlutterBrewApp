import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({this.toggleView});
  final Function? toggleView;


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey=GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  //text field state
  String email='';
  String password='';
  String error="";
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading ? LoadingSpinner() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to brew Crew'),
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView!();
              },
              icon: Icon(Icons.person),
              label: Text("Sign in")
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,//keeps track of our form
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val)=>val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){//every time the value changes
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val)=>val!.length<6 ? 'Enter a password 6 chars long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    // print(email);
                    // print(password);
                    setState(() {
                      loading=true;
                    });
                    dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error="Please supply a valid email";
                        loading=false;
                      });
                    }
                  }
                },
                color: Colors.pink[400],
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20,),
              Text(error,style: TextStyle(color: Colors.red, fontSize: 14),)
            ],
          ),
        ),
      ),
    );
  }
}
