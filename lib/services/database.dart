import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/brew.dart';
import 'package:firebase_tutorial/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String name, String description)async{
    return await brewCollection.document(uid).setData({
      'name': name,
      'description' : description
    });
  }

// brewlist from Snapshot

List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
    return Brew(name: doc.data['name']??'',
    description: doc.data['description']??'',
    );
  }).toList();
}

//get brewstream

Stream<List<Brew>> get brews{
  return brewCollection.snapshots().map(_brewListFromSnapshot);
}

UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot){
  return UserData(name: documentSnapshot.data['name'],description: documentSnapshot.data['description'], uid:uid);
}


//get user doc stream
Stream<UserData> get userData{
  return brewCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}

  
}