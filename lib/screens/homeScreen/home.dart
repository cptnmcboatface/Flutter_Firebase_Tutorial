import 'package:firebase_tutorial/models/brew.dart';
import 'package:firebase_tutorial/screens/homeScreen/brew_list.dart';
import 'package:firebase_tutorial/screens/homeScreen/settings_form.dart';
import 'package:firebase_tutorial/services/auth.dart';
import 'package:firebase_tutorial/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    
    void _showSettingsPanel(){
      showModalBottomSheet(isScrollControlled : true,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))), context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm());
      });
    }

    return StreamProvider<List<Brew>>.value(
          value: DatabaseService().brews,
          child: Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text('MY APP'),
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(icon: Icon(Icons.person),
                label: Text('Log Out'),
                  onPressed: ()async{
                  await _auth.singOut();
                },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.settings),
                  label : Text("Settings"),
                  onPressed: ()=>_showSettingsPanel(),
                )
              ],
            ),
            body: BrewList(),
          ),
      );
  }
}