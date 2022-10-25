import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expose_master/backend/classes/student_data.dart';
import 'package:expose_master/backend/classes/user_data.dart';

import 'package:firebase_storage/firebase_storage.dart';

class SystemData {
  static SingleUser? userData;

  static SingleStudent? studentData;

  static String ipServer = "http://25.0.213.77:3000";

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static CollectionReference userSesions =
      firebaseFirestore.collection('userSesions');

  static CollectionReference userRating =
      firebaseFirestore.collection("Rating");

  static CollectionReference userComments =
      firebaseFirestore.collection("Comments");
}
