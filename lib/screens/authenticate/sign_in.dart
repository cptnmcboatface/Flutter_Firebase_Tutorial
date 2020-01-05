import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/shared/constants.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  bool loading= false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    if(loading){
      return Loading();
    }else{
       return Scaffold(
        backgroundColor: Colors.brown[100], // strength 100
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0, // removes the drop shadow
          title: Text('SIGN IN '),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Register"),
              onPressed: (){
                widget.toggleView();
              },
            )
          ],
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
                  validator: (val)=>val.isEmpty? 'Enter Valid Email':null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val)=>val.length<6 ? 'Enter Valid Password':null ,
                  obscureText: true,
                  onChanged: (val){
                    setState(() =>password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.brown[600],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error= 'Error signing in. Make sure you entered correct information';  
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
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
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