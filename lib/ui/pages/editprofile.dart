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
  final _formkey = GlobalKey<FormState>();
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

  Future chooseFile(String type) async{
    ImageSource imgSrc;
    if(type == "camera"){
      imgSrc = ImageSource.camera;
    }else{
      imgSrc = ImageSource.gallery;
    }

    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50
    ); 
    setState(() {
      imageFile = selectedImage;
    });
  }

  void showFileDialog(BuildContext ctx){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Pick Image from:"),
          actions: [
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("camera");
              },
              icon: Icon(Icons.camera_alt),
              label: Text("Camera"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
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

  @override
  void dispose(){
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPhone.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPhone.clear();
    ctrlPassword.clear();
    setState(() {
      imageFile = null;
    });
  }

  Future<void> getUser() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).get().then((value) {
      setState(() {
        name = value['name'].toString();
        email = auth.currentUser.email;
        phone = value['phone'].toString();
        password = value['password'].toString();
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Users users = ModalRoute.of(context).settings.arguments;
    // final ctrlName = new TextEditingController(text: name);
    ctrlName.text = name;
    ctrlEmail.text = email;
    ctrlPhone.text = phone;
    ctrlPassword.text = password;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(16),
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      // TextFormField(
                      //   // controller: ctrlName,
                      //   keyboardType: TextInputType.name,
                      //   style: TextStyle(
                      //     color: MyTheme.lightTheme().primaryColor,
                      //   ),
                      //   decoration: InputDecoration(
                      //     labelText: "Image",
                      //     prefixIcon: Icon(
                      //       Icons.label,
                      //       color: MyTheme.lightTheme().primaryColor,
                      //     ),
                      //     border: OutlineInputBorder(),
                      //     labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                      //   ),
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   validator: (value){
                      //   if(value.isEmpty){ 
                      //     return "Please fill the field!";
                      //   }else{
                      //     return null;
                      //   }
                      //   },
                      // ),
                      SizedBox(height:24),
                      TextFormField(
                        controller: ctrlName,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(
                            Icons.label,
                            color: MyTheme.lightTheme().primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                        if(value.isEmpty){ 
                          return "Please fill the field!";
                        }else{
                          return null;
                        }
                        },
                      ),
                      SizedBox(height:24),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        // maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.power,
                            color: MyTheme.lightTheme().primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value.isEmpty){ 
                            return "Please fill the field!";
                          }else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height:24),
                      TextFormField(
                        controller: ctrlPhone,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            color: MyTheme.lightTheme().primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                        if(value.isEmpty){ 
                          return "Please fill the field!";
                        }else{
                          return null;
                        }
                        },
                      ),
                      SizedBox(height:24),
                      TextFormField(
                        controller: ctrlPassword,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: MyTheme.lightTheme().primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                        if(value.isEmpty){ 
                          return "Please fill the field!";
                        }else{
                          return null;
                        }
                        },
                      ),
                      SizedBox(height:24),
                      imageFile == null ?
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: (){
                                showFileDialog(context);
                              }, 
                              icon: Icon(Icons.photo_camera),
                              label: Text("Choose Photo"),
                              style: ElevatedButton.styleFrom(
                                primary: MyTheme.lightTheme().primaryColor,
                                elevation: 0,
                              ),
                            ),
                            SizedBox(height:24),
                            Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                            Text(
                              "File Not Found.", 
                              style: TextStyle(
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                            ),
                          ],
                        )
                      :
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: (){
                                showFileDialog(context);
                              }, 
                              icon: Icon(Icons.photo_camera),
                              label: Text("Replace Photo"),
                              style: ElevatedButton.styleFrom(
                                primary: MyTheme.lightTheme().primaryColor,
                                elevation: 0,
                              ),
                            ),
                            SizedBox(height:24), 
                            Semantics(
                              child: Image.file(
                                File(imageFile.path),
                                width: 100,
                              )
                            )
                          ],
                        ),
                      SizedBox(height:40),
                      ElevatedButton.icon(
                            onPressed: () async{
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                                Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, "", "");
                                await AuthServices.updateUser(users, imageFile).then((value){
                                  if(value == "success"){
                                    ActivityServices.showToast("Save profile sucessfull!", Colors.green);
                                    clearForm();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  }else{
                                    ActivityServices.showToast("Save profile failed!", Colors.red);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              }else{
                                ActivityServices.showToast("Please check form fields!", Colors.red);
                              }
                            }, 
                            icon: Icon(Icons.save),
                            label: Text("Save Profile"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.lightTheme().primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                            )
                      ),
                    ],
                  )
                ),
              ]
            ),
            isLoading == true
              ? ActivityServices.loadings()
              : Container()
          ],
        )
      )
    );
  }
}