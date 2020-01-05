import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/screens/authenticate/authenticate.dart';
import 'package:firebase_tutorial/screens/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or auth widget
    final user = Provider.of<User> (context);
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}