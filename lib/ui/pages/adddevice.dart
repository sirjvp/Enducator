part of 'pages.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlWatt = TextEditingController();
  final ctrlQuantity = TextEditingController();
  final ctrlDay = TextEditingController();
  final ctrlTime = TextEditingController();
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

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
    ctrlWatt.dispose();
    ctrlQuantity.dispose();
    ctrlDay.dispose();
    ctrlTime.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlWatt.clear();
    ctrlQuantity.clear();
    ctrlDay.clear();
    ctrlTime.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Device"),
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
                        controller: ctrlWatt,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        // maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Watt",
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
                        controller: ctrlQuantity,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Quantity",
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
                        controller: ctrlDay,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Day Usage (Days)",
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
                      TextFormField(
                        controller: ctrlTime,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: MyTheme.lightTheme().primaryColor,
                        ),
                        decoration: InputDecoration(
                          labelText: "Time Usage (Hours)",
                          prefixIcon: Icon(
                            Icons.lock_clock,
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
                              if(_formkey.currentState.validate() && imageFile != null){
                                setState(() {
                                  isLoading = true;
                                });
                                Devices devices = Devices("", ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), int.parse(ctrlTime.text), "", FirebaseAuth.instance.currentUser.uid, "", "");
                                await DeviceServices.addDevice(devices, imageFile).then((value){
                                  if(value == true){
                                    ActivityServices.showToast("Add device sucessfull!", Colors.green);
                                    clearForm();
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }else{
                                    ActivityServices.showToast("Save device failed!", Colors.red);
                                  }
                                });
                              }else{
                                ActivityServices.showToast("Please check form fields!", Colors.red);
                              }
                            }, 
                            icon: Icon(Icons.save),
                            label: Text("Save Device"),
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