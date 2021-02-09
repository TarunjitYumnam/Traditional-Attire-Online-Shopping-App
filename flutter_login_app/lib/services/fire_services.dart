import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getUserId(){
    return _firebaseAuth.currentUser.uid;
  }
  final CollectionReference productRef =
  FirebaseFirestore.instance.collection("Manipur Products");

  final CollectionReference userRef =
  FirebaseFirestore.instance.collection("Users");
}