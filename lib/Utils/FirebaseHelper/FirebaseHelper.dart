import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper
{
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();


  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  //Insert Data(Notes Data) In Firestote Database in Farebase
  Future<void> InsertNotesData({required String note})
  async {
    await firebaseFirestore.collection("Notes").add({
      "note" : note,
      "status" : false
    });
  }

  //Read Data(Notes Data) In Firestote Database in Farebase
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadNotesData()
  {
    return firebaseFirestore.collection("Notes").snapshots();
  }

  //Delete Data(Notes Data) In Firestote Database in Farebase
  void DeleteNotesData({required String id})
  {
    firebaseFirestore.collection("Notes").doc(id).delete();
  }

  //Update Data(Notes Data) In Firestote Database in Farebase
  void UpdateNotesData({required String id, required String note, required bool status})
  {
    firebaseFirestore.collection("Notes").doc(id).update({"note" : note, "status" : status});
  }

}