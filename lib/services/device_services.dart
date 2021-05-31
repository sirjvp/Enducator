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

  static Future<bool> addDevice(Devices devices, PickedFile imgFile) async{
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    deviceDocument = await deviceCollection.doc(uid).collection("devices").add({
      // if(devices.deviceSelect == 'TV'){}
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
      ref = FirebaseStorage.instance.ref().child("images").child(deviceDocument.id+".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() =>
        ref.getDownloadURL().then((value)  => imgUrl = value,)
      );

      deviceCollection.doc(deviceDocument.id).update(
        {
          'deviceId': deviceDocument.id,
          'deviceImage': imgUrl,
        }
      );

      return true;
    }else{
      return false;
    }
  }

  static Future<bool> deleteDevice(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await deviceCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

}