import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/services/database.dart';
import 'package:firebase_tutorial/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_tutorial/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  final _formKey = GlobalKey<FormState>();
  String _currentName=null;
  String _currentDescription=null;
  
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserData userD = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Update Preferences", style: TextStyle(fontSize: 20),),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userD.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val)=> val.isEmpty? 'Enter Valid Name':null,
                  onChanged: (val)=> setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userD.description,
                  decoration: textInputDecoration.copyWith(hintText: 'Description'),
                  validator: (val)=> val.isEmpty? 'Enter Valid Description':null,
                  onChanged: (val)=> setState(() => _currentDescription = val),
                ),
                SizedBox(height: 20.0,),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: Colors.brown[800],
                  onPressed: ()async{
                    print(_currentName);
                    print(_currentDescription);
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid:user.uid).updateUserData(_currentName??userD.name, _currentDescription??userD.description);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, ),
                )
              ],
            )
          );
        }
        else{
          return Loading();
        }
      }
    );
    }
}