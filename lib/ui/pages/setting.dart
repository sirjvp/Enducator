part of 'pages.dart';

class Setting extends StatefulWidget {
  static const String routeName = "/setting";

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  bool isLoading = false;
  bool isClicked = false;
  final ctrlKwh = TextEditingController();
  final ctrlModal = TextEditingController();
  int ctrlCurrency = 1;

  String modal = "";
  int currency = 1;
  String edit = "";
  bool isSwitched = false;

  Future<void> getUser() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).get().then((value) {
      setState(() {
        modal = value['modal'].toString();
        currency = value['currency'];
      });
    });
  }

  void dialogModal(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlModal,
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
                  // if(_formkey.currentState.validate()){
                    setState(() {
                      isLoading = true;
                    });
                    double modal = double.parse(ctrlModal.text);
                    int currency = ctrlCurrency;
                    await AuthServices.updateSetting(modal, currency).then((value){
                      if(value == "success"){
                        ActivityServices.showToast("Save setting sucessfull!", Colors.green);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }else{
                        ActivityServices.showToast("Save setting failed!", Colors.red);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                    // }else{
                    //   ActivityServices.showToast("Please check form fields!", Colors.red);
                    // }
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

  void dialogBox(BuildContext ctx){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete all devices?"),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                    isLoading = true;
                  });
                  await DeviceServices.deleteAll().then((value){
                    if(value == true){
                      ActivityServices.showToast("Delete all devices sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Delete all devices failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: Text(
                        "Yes",
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
                child: Text(
                        "No",
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
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctrlModal.text = modal;
    if(currency == 1){
      isSwitched = false;
    }else{
      isSwitched = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings", style: TextStyle(color: Colors.white)),
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
                            ListTile(
                                  leading: Text(
                                    "Change to dollar",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: 
                                    Switch(
                                      value: isSwitched,
                                      onChanged: (value) async{
                                        setState(() {
                                          isSwitched = value;
                                          print(isSwitched);
                                          isLoading = true;
                                        });
                                        if(isSwitched == true){
                                          currency = 2;
                                        }else{
                                          currency = 1;
                                        }
                                        double modal = double.parse(ctrlModal.text);
                                        await AuthServices.updateSetting(modal, currency).then((value){
                                          if(value == "success"){
                                            ActivityServices.showToast("Edit setting sucessfull!", Colors.green);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }else{
                                            ActivityServices.showToast("Save setting failed!", Colors.red);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        });
                                      },
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                    ),
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
                                edit = "Edit Modal";
                                dialogModal(context, edit);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "1 kwh = Rupiah",
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
                                        modal,
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
                              onTap: () async{
                                dialogBox(context);
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Delete all devices",
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
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async{
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthServices.signOut().then((value) {
                                  if (value == true) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        "Logout success", Colors.green);
                                    //menuju ke tahap selanjutnya
                                    // Navigator.pushReplacementNamed(
                                    //     context, Login.routeName);
                                    bool logout = true;
                                    Navigator.pop(context, logout);
                                    //pushNamed = bisa kembali, ga ditutup
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        "Logout failed", Colors.red);
                                  }
                                });
                              },
                              child: ListTile(
                                  leading: Text(
                                    "Log out",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                        
                                        ),
                                        textAlign: TextAlign.center,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                              ),
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
