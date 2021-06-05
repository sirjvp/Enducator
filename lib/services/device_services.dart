part of 'services.dart';

class DeviceServices{

  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference deviceCollection = FirebaseFirestore.instance.collection("users");
  static DocumentReference deviceDocument;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addDevice(Devices devices) async{
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    deviceDocument = await deviceCollection.doc(uid).collection("devices").add({
      'deviceId': devices.deviceId,
      'deviceName': devices.deviceName,
      'deviceWatt': devices.deviceWatt,
      'deviceQuantity': devices.deviceQuantity,
      'deviceDay': devices.deviceDay,
      'deviceTime': devices.deviceTime,
      'deviceImage': devices.deviceImage,
      'addBy': auth.currentUser.uid,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });

    if(deviceDocument != null){
      deviceCollection.doc(uid).collection("devices").doc(deviceDocument.id).update({
        'deviceId': deviceDocument.id,
      });

      return true;
    }else{
      return false;
    }
  }

  static Future<String> updateDevice(Devices devices) async{
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    String msg = "";
    await deviceCollection.doc(uid).collection("devices").doc(devices.deviceId).update({
      'deviceName': devices.deviceName,
      'deviceWatt': devices.deviceWatt,
      'deviceQuantity': devices.deviceQuantity,
      'deviceDay': devices.deviceDay,
      'deviceTime': devices.deviceTime,
      'deviceImage': devices.deviceImage,
      'updatedAt': dateNow,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }

  static Future<bool> deleteDevice(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("devices").doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

  static Future<bool> deleteAll() async {
    bool hsl = true;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("devices").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

}