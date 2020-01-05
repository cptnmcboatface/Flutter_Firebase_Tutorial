import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create User obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null? User(uid:user.uid) : null;
  }
  //sign in anonymous
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
      //.map((FirebaseUser user)=>_userFromFirebaseUser(user));
  }
  Future signInAnon()async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register email & password

  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;

      // create a ew document for user with uid
      await DatabaseService(uid:user.uid).updateUserData('new_user', 'new_user');

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future singOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}