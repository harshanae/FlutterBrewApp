import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/sys_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final CollectionReference brewCollection=FirebaseFirestore.instance.collection("brews");
  DatabaseService({this.uid});
  final String? uid;


  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars':sugars,
      'name': name,
      'strength': strength
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){

      return snapshot.docs.map((doc){
        return Brew(
            name: doc['name'] ?? '',
            strength: doc['strength'] ?? 0,
            sugars: doc['sugars'] ?? '0'
        );
      }).toList();

  }

  //userdata from snapshot

  UserData _userdataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  //get user doc stream

  Stream<UserData> get userdata{
    return brewCollection.doc(uid).snapshots()
    .map(_userdataFromSnapshot);
  }


}