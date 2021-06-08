part of 'pages.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "/editprofile";

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  bool isLoading = false;
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlPassword = TextEditingController();
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  String name = "";
  String email = "";
  String phone = "";
  String password = "";
  String avatar = "";
  String edit = "";

  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else {
      imgSrc = ImageSource.gallery;
    }

    final selectedImage =
        await imagePicker.getImage(source: imgSrc, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
      isLoading = true;
    });

    Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, 1, "", "");
    await AuthServices.updateUser(users, imageFile).then((value){
      if(value == "success"){
        ActivityServices.showToast("Save profile sucessfull!", Colors.green);
          setState(() {
            isLoading = false;
          });
        Navigator.pop(context);
        Navigator.pop(context);
      }else{
        ActivityServices.showToast("Save profile failed!", Colors.red);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void showFileDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Pick Image from:"),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("camera");
              },
              icon: Icon(Icons.camera_alt),
              label: Text("Camera"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                chooseFile("gallery");
              },
              icon: Icon(Icons.folder_outlined),
              label: Text("Gallery"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }

  void dialogName(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlName,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });
                  Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, 1, "", "");
                  await AuthServices.updateUser(users, imageFile).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save profile sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save profile failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogPhone(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlPhone,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });
                  Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, 1, "", "");
                  await AuthServices.updateUser(users, imageFile).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save profile sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save profile failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogPassword(BuildContext ctx, String password){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlPassword,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                    isLoading = true;
                  });
                  if(ctrlPassword.text == password){
                    setState(() {
                        isLoading = false;
                    });
                    Navigator.pop(context);
                    dialogNewPassword(context);
                  }else{
                    setState(() {
                        isLoading = false;
                    });
                    ActivityServices.showToast("Password do not match", Colors.red);
                  }
                },
                child: 
                  Text(
                    "Ok",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogNewPassword(BuildContext ctx){
    showDialog(
      context: ctx,
      builder: (ctx){
        ctrlPassword.text = "";
        return AlertDialog(
          title: Text("Enter your new password", textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlPassword,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                    isLoading = true;
                  });
                  Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, 1, "", "");
                  await AuthServices.updateUser(users, imageFile).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save profile sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save profile failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Users users = ModalRoute.of(context).settings.arguments;
    ctrlName.text = users.name;
    ctrlEmail.text = users.email;
    ctrlPhone.text = users.phone;
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          )
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showFileDialog(context);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Profile Photo",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(users.avatar),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                edit = "Edit Name";
                                dialogName(context, edit);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        ctrlName.text,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                edit = "Edit Phone";
                                dialogPhone(context, edit);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Phone",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        ctrlPhone.text,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                edit = "Enter your current password";
                                dialogPassword(context, users.password);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Change password",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}
