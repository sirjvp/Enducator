part of 'services.dart';

class CalculateServices{

  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  static DocumentReference userDoc;

  static Future<bool> addReport(Calculate calculate) async{
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    userDoc = await userCollection.doc(uid).collection("reports").add({
      'reportId': calculate.reportId,
      'totalDevice': calculate.totalDevice,
      'totalWatt': calculate.totalWatt,
      'price': calculate.price,
      'time': calculate.time,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });

    if(userDoc != null){
      userCollection.doc(uid).collection("reports").doc(userDoc.id).update({
        'reportId': userDoc.id,
      });

      return true;
    }else{
      return false;
    }
  }

  static Future<bool> updateReport(Calculate calculate) async{
    bool result = true;
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    
    await userCollection.doc(uid).collection("reports").doc(calculate.reportId).update({
      'totalDevice': calculate.totalDevice,
      'totalWatt': calculate.totalWatt,
      'price': calculate.price,
      'updatedAt': dateNow,
    }).then((value) {
      result = true;
    }).catchError((onError) {
      result = false;
    });
    return result;
  }

  static Future<bool> deleteReport(String rid) async {
    bool result = true;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).collection("reports").doc(rid).delete().then((value) {
      result = true;
    }).catchError((onError) {
      result = false;
    });
    return result;
  }
}