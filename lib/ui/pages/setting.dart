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
  final _formkey = GlobalKey<FormState>();
  final ctrlKwh = TextEditingController();
  final ctrlModal = TextEditingController();

  String modal = "";

  Future<void> getUser() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).get().then((value) {
      setState(() {
        modal = value['modal'].toString();
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
    ctrlModal.text = modal;
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                ListView(padding: EdgeInsets.all(16), children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "1 kwh = Rupiah",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlModal,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          SizedBox(height: 24),
                          // TextFormField(
                          //   controller: ctrlTime,
                          //   keyboardType: TextInputType.number,
                          //   style: TextStyle(
                          //     color: MyTheme.lightTheme().primaryColor,
                          //   ),
                          //   decoration: InputDecoration(
                          //     labelText: "Time Usage (Hours)",
                          //     prefixIcon: Icon(
                          //       Icons.lock_clock,
                          //       color: MyTheme.lightTheme().primaryColor,
                          //     ),
                          //     border: OutlineInputBorder(),
                          //     labelStyle: new TextStyle(
                          //         color: MyTheme.lightTheme().primaryColor),
                          //   ),
                          //   autovalidateMode:
                          //       AutovalidateMode.onUserInteraction,
                          //   validator: (value) {
                          //     if (value.isEmpty) {
                          //       return "Please fill the field!";
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          // ),
                          SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthServices.updateSetting(int.parse(ctrlModal.text)).then((value){
                                  if(value == "success"){
                                    ActivityServices.showToast("Edit setting sucessfull!", Colors.green);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  }else{
                                    ActivityServices.showToast("Save setting failed!", Colors.red);
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
                            label: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.lightTheme().primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                            )
                          ),
                          SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () async {
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
                                  Navigator.pushReplacementNamed(
                                      context, Login.routeName);
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
                            icon: Icon(Icons.logout),
                            label: Text("Logout"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.lightTheme().primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                            )
                          ),
                        ],
                      )),
                ]),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}
