part of 'services.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference userDoc;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<String> signUp(Users users) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String msg = "";
    String token = "";
    String uid = "";

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: users.email, password: users.password);
    uid = userCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();

    await userCollection.doc(uid).set({
      'uid': uid,
      'name': users.name,
      'phone': users.phone,
      'email': users.email,
      'password': users.password,
      'avatar': users.avatar,
      'modal': users.modal,
      'currency': users.currency,
      'token': token,
      'isOn': 0,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });
    auth.signOut();

    return msg;
  }

  static Future<String> signIn(String email, String password) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String msg = "";
    String uid = "";
    String token = "";

    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    uid = userCredential.user.uid;
    token = await FirebaseMessaging.instance.getToken();

    await userCollection.doc(uid).update({
      'isOn': '1',
      'token': token,
      'updatedAt': dateNow,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }

  static Future<bool> signOut() async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;

    await auth.signOut().whenComplete(() {
      userCollection.doc(uid).update({
        'isOn': '0',
        'token': '-',
        'updatedAt': dateNow,
      });
    });

    return true;
  }

  static Future<String> updateUser(Users users, PickedFile imgFile) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    String msg = "";
    userDoc = userCollection.doc(uid);
    if (userDoc != null) {
      if(imgFile != null) {
        ref = FirebaseStorage.instance.ref().child("images").child(userDoc.id + ".png");
        uploadTask = ref.putFile(File(imgFile.path));

        await uploadTask.whenComplete(() => ref.getDownloadURL().then(
          (value) => imgUrl = value,
        ));

        await userCollection.doc(userDoc.id).update(
        {
          'avatar': imgUrl,
        });
      }

      await userCollection.doc(userDoc.id).update({
        'name': users.name,
        'phone': users.phone,
        'email': users.email,
        'password': users.password,
        'updatedAt': dateNow,
      }).then((value) {
        msg = "success";
      }).catchError((onError) {
        msg = onError;
      });
    }
    return msg;
  }

  static Future<String> updateSetting(double modal, int currency) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    String msg = "";

    await userCollection.doc(uid).update({
      'modal': modal,
      'currency': currency,
      'updatedAt': dateNow,
    }).then((value) {
      msg = "success";
    }).catchError((onError) {
      msg = onError;
    });

    return msg;
  }
}
