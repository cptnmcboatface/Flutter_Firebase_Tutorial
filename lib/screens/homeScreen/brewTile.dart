import 'package:flutter/material.dart';
import 'package:firebase_tutorial/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child : Card(
        color: Colors.brown[30],
        margin : EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[500],
          ),
          title: Text(brew.name),
          subtitle: Text(brew.description),
        ),
      )
    );
  }
}