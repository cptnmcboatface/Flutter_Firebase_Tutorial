import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/shared/constants.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email='';
  String password ='';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  
  Widget build(BuildContext context) {
    if (loading){
      return Loading();
    }
    else{
      return Scaffold(  
        backgroundColor: Colors.brown[100], // strength 100
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0, // removes the drop shadow
          title: Text('SIGN UP '),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Sign In"),
              onPressed: (){
                widget.toggleView();
              },
            )
          ]
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child:Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val)=> val.isEmpty ? 'Enter Email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val)=> val.length<6 ? 'Enter valid Password (6 chars or longer)' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() =>password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.brown[600],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(()=>loading = !loading);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          setState(()=>loading = !loading);
                          error = 'Please Give Valid email';
                        });
                      }else{
                        error = '';
                      }
                    }
                  },
                ),
                SizedBox(height: 12,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                )
              ],

          ),)
          // child:RaisedButton(
          //   child: Text('Sign in anon'),
          //   onPressed: ()async{
          //       dynamic result =  await _auth.signInAnon();
          //       if(result == null){
          //         print('eror anon sign in');
          //       }else{
          //         print('Signed in');
          //       }

          //   },
          // ),
        ),
      );
    }
    
    }
}